# 🔧 Fix for "Sensors Unavailable" Issue

## Problem

Mac frontend shows **"sensors unavailable"** even though ROS topics are publishing on the Jetson Nano and visible from the Remote PC terminal.

## Root Cause

The issue is in the **sensor availability check** that runs between the frontend and backend:

### Data Flow for Sensor Availability:

```
Mac Frontend (browser)
    ↓ HTTP request every 2 seconds
    ↓ GET /api/sensors/availability
Backend on Remote PC (HP laptop)
    ↓ Calls get_required_topics_status()
    ↓ Uses rospy.get_published_topics()
    ↓ Checks if ROS_MASTER_URI is reachable
Jetson Nano (ROS master)
    ↓ Returns list of published topics
Backend
    ↓ Checks if all 4 required topics exist
    ↓ Returns {available: true/false}
Frontend
    ↓ Shows "sensors available" or "sensors unavailable"
```

### Required Topics Checked:

The backend checks for these 4 topics (from `app/services/ros_sensor_bridge.py:17-22`):

1. `/sensors/sht40/temperature`
2. `/sensors/sht40/humidity`
3. `/sensors/thermal/mean`
4. `/camera/color/image_raw`

**If ANY of these 4 topics are missing, backend returns `available: false`**

---

## Current Configuration

### Backend Configuration (`application/backend/.env`):

```env
ROS_MASTER_URI=http://10.0.0.46:11311
ROS_IP=10.0.0.170
```

This means:
- **Jetson Nano IP**: `10.0.0.46` (ROS master)
- **Remote PC IP**: `10.0.0.170` (where backend runs)

### Frontend Configuration (`application/src/services/api.js:1`):

```javascript
const API_BASE_URL = 'http://10.18.50.245:8000/api';
```

**⚠️ POTENTIAL ISSUE**: Frontend is trying to reach backend at `10.18.50.245`, but backend's ROS_IP is `10.0.0.170`. These might be different network interfaces!

---

## Diagnostic Steps

### Quick Check (Run on Remote PC):

```bash
cd ~/Dev/pyroscope/application/backend/scripts
./diagnose_sensor_availability.sh
```

This script will check:
1. ✅ Network connectivity to Jetson
2. ✅ ROS master port reachable
3. ✅ All 4 required topics exist
4. ✅ Backend API returns correct availability

### Manual Checks:

#### 1. Check Backend Can Reach ROS Master

On Remote PC:
```bash
# Set ROS environment
export ROS_MASTER_URI=http://10.0.0.46:11311
export ROS_IP=10.0.0.170

# Check if topics are visible
rostopic list | grep sensors
```

Expected output:
```
/sensors/sht40/humidity
/sensors/sht40/temperature
/sensors/thermal/image
/sensors/thermal/mean
```

If you see these, ROS connection is working from Remote PC.

#### 2. Check Backend API Directly

On Remote PC:
```bash
curl http://localhost:8000/api/sensors/availability | python3 -m json.tool
```

**Expected (working)**:
```json
{
  "available": true,
  "missing_topics": []
}
```

**If broken**:
```json
{
  "available": false,
  "missing_topics": [
    "/sensors/sht40/temperature",
    "/sensors/sht40/humidity",
    "/sensors/thermal/mean",
    "/camera/color/image_raw"
  ]
}
```

#### 3. Check from Mac (Frontend Perspective)

On Mac:
```bash
curl http://10.18.50.245:8000/api/sensors/availability | python3 -m json.tool
```

Should return same as above.

---

## Most Likely Issues & Fixes

### Issue 1: ROS Topics Not Publishing on Jetson

**Symptom**: `rostopic list` on Jetson doesn't show sensor topics

**Fix on Jetson**:
```bash
# Check if sensor launch file is running
rosnode list | grep sensor

# If not, start sensors
roslaunch pyroscope_sensors sensors.launch
```

---

### Issue 2: Backend Can't Reach ROS Master

**Symptom**:
- `rostopic list` works on Jetson
- `rostopic list` works on Remote PC terminal with `ROS_MASTER_URI` set
- But backend API returns `available: false`

**Possible causes**:
1. Backend not reading `.env` file
2. Backend process doesn't have ROS environment variables
3. Wrong IP in `ROS_MASTER_URI`

**Fix**:
```bash
# On Remote PC, restart backend
cd ~/Dev/pyroscope/application/backend

# Verify .env has correct values
grep ROS .env

# Should show:
# ROS_MASTER_URI=http://10.0.0.46:11311  (Jetson IP)
# ROS_IP=10.0.0.170                       (Remote PC IP)

# Restart backend
python run.py
```

---

### Issue 3: Network Mismatch

**Symptom**: Different IPs in frontend API client vs backend `.env`

**Current state**:
- Frontend connects to: `10.18.50.245:8000`
- Backend ROS_IP set to: `10.0.0.170`

**Check**:
```bash
# On Remote PC, find actual IP
hostname -I
```

**Fix** (if IPs don't match):

Update `application/src/services/api.js`:
```javascript
const API_BASE_URL = 'http://10.0.0.170:8000/api';  // Match backend's ROS_IP
```

---

### Issue 4: Python rospy Module Not Available

**Symptom**: Backend can't import `rospy`

**Check** (on Remote PC):
```bash
# Try importing rospy in backend's Python environment
cd ~/Dev/pyroscope/application/backend
python -c "import rospy; print('rospy works')"
```

If this fails, rospy isn't available in the backend Python environment.

**Fix**: Backend needs Python 2.7 with ROS or ROS bridge. This is complex - easier to use standalone `ros_sensor_bridge.py` script instead.

---

## Alternative: Use Standalone ROS Sensor Bridge

If backend's in-process ROS bridge isn't working, use the standalone script:

### On Remote PC:

```bash
# Start standalone sensor bridge (Python 2)
cd ~/Dev/pyroscope/application/backend/scripts
python ros_sensor_bridge.py
```

This script:
1. Subscribes to ROS topics (Python 2 with rospy)
2. Writes sensor data to `~/Dev/pyroscope/application/backend/sensor_data/latest_sensors.json`
3. Backend reads this JSON file instead of directly checking ROS topics

### Then check:

```bash
# Verify JSON file is being updated
watch -n 1 cat ~/Dev/pyroscope/application/backend/sensor_data/latest_sensors.json
```

Should show sensor values updating every 0.5 seconds.

---

## Expected Working State

When everything is working:

1. **On Jetson Nano**: `roslaunch pyroscope_sensors sensors.launch` is running
2. **On Remote PC**:
   - Backend is running: `python run.py`
   - Backend can reach ROS master at `10.0.0.46:11311`
   - OR standalone `ros_sensor_bridge.py` is writing to JSON file
3. **On Mac**:
   - Frontend can reach backend at configured IP
   - Browser shows **"sensors available"** in green

---

## Quick Fix Checklist

Run these in order:

- [ ] **On Jetson**: Verify topics publishing
  ```bash
  rostopic list | grep sensors
  rostopic echo /sensors/sht40/temperature -n 1
  ```

- [ ] **On Remote PC**: Verify backend can see topics
  ```bash
  export ROS_MASTER_URI=http://10.0.0.46:11311
  export ROS_IP=10.0.0.170
  rostopic list | grep sensors
  ```

- [ ] **On Remote PC**: Test backend API
  ```bash
  curl http://localhost:8000/api/sensors/availability | python3 -m json.tool
  ```

- [ ] **On Mac**: Test from frontend perspective
  ```bash
  curl http://10.18.50.245:8000/api/sensors/availability | python3 -m json.tool
  ```

- [ ] **If still failing**: Run diagnostic script
  ```bash
  cd ~/Dev/pyroscope/application/backend/scripts
  ./diagnose_sensor_availability.sh
  ```

---

## Files Involved

### Backend Files:
- `application/backend/.env` - ROS configuration (ROS_MASTER_URI, ROS_IP)
- `application/backend/app/config.py` - Reads .env settings
- `application/backend/app/services/ros_sensor_bridge.py` - In-process ROS bridge
  - `get_required_topics_status()` function (line 237) - checks topic availability
  - `REQUIRED_SENSOR_TOPICS` list (line 17) - defines required topics
- `application/backend/app/routers/sensors.py` - API endpoint
  - `/api/sensors/availability` endpoint (line 60) - returns availability status
- `application/backend/scripts/ros_sensor_bridge.py` - Standalone sensor bridge (Python 2)

### Frontend Files:
- `application/src/services/api.js` - API client (line 1: API_BASE_URL)
- `application/src/components/SensorPanel.jsx` - Shows availability status
  - `pollAvailability()` function (line 30) - polls every 2 seconds
  - Shows "sensors available" vs "sensors unavailable" (line 54-55)

---

## Summary

The "sensors unavailable" message is controlled by the `/api/sensors/availability` endpoint, which checks if all 4 required ROS topics are currently published on the ROS master.

**Most common fixes**:
1. Restart sensor launch file on Jetson
2. Verify network connectivity between Remote PC and Jetson
3. Restart backend to establish ROS connection
4. Use standalone `ros_sensor_bridge.py` if in-process bridge fails

Run `./diagnose_sensor_availability.sh` to identify the exact issue.
