# 🔍 Sensor Availability Check - Data Flow

## The Complete Pipeline

```
┌─────────────────────────────────────────────────────────────────────────┐
│  JETSON NANO (10.0.0.46)                                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                           │
│  ROS MASTER (port 11311)                                                 │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  Published Topics:                                                │  │
│  │  • /sensors/sht40/temperature   (Float64)                        │  │
│  │  • /sensors/sht40/humidity      (Float64)                        │  │
│  │  • /sensors/thermal/mean        (Float64)                        │  │
│  │  • /camera/color/image_raw      (Image)                          │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
                        WiFi / ROS (port 11311)
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│  REMOTE PC / HP Laptop (10.0.0.170 or 10.18.50.245?)                    │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                           │
│  FastAPI Backend (port 8000)                                             │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  .env Configuration:                                              │  │
│  │  ROS_MASTER_URI=http://10.0.0.46:11311                           │  │
│  │  ROS_IP=10.0.0.170                                                │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  API Endpoint: /api/sensors/availability                                 │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  def get_sensor_availability():                                   │  │
│  │      status = get_required_topics_status()  ← CHECKS ROS         │  │
│  │      return {                                                     │  │
│  │          "available": True/False,                                 │  │
│  │          "missing_topics": [...]                                  │  │
│  │      }                                                            │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Function: get_required_topics_status()                                  │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  1. Check if ROS_MASTER_URI is configured ✓                      │  │
│  │  2. Connect to ROS master at 10.0.0.46:11311                     │  │
│  │  3. Call rospy.get_published_topics()                            │  │
│  │  4. Check if ALL 4 topics exist:                                 │  │
│  │     ☑ /sensors/sht40/temperature                                 │  │
│  │     ☑ /sensors/sht40/humidity                                    │  │
│  │     ☑ /sensors/thermal/mean                                      │  │
│  │     ☑ /camera/color/image_raw                                    │  │
│  │  5. Return available=True ONLY if all 4 found                    │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
                          HTTP (port 8000)
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│  MAC (Frontend)                                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                           │
│  api.js Configuration:                                                   │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  const API_BASE_URL = 'http://10.18.50.245:8000/api'             │  │
│  │                                                                   │  │
│  │  ⚠️  POTENTIAL MISMATCH:                                         │  │
│  │     Frontend: 10.18.50.245                                        │  │
│  │     Backend:  10.0.0.170 (from .env ROS_IP)                      │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  SensorPanel.jsx                                                         │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │  Every 2 seconds:                                                 │  │
│  │    GET /api/sensors/availability                                  │  │
│  │                                                                   │  │
│  │    Response: { available: true/false }                            │  │
│  │                                                                   │  │
│  │    if (available) {                                               │  │
│  │      Show: "sensors available" 🟢                                │  │
│  │    } else {                                                       │  │
│  │      Show: "sensors unavailable" 🔴  ← YOU ARE HERE             │  │
│  │    }                                                              │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Where Things Can Break

### ❌ Issue 1: Network Between Devices

```
JETSON (10.0.0.46)  ✗✗✗  REMOTE PC (10.0.0.170)
                     ↑
         Cannot reach ROS master on port 11311
```

**Symptoms**:
- `rostopic list` works on Jetson
- `rostopic list` fails on Remote PC (even with `export ROS_MASTER_URI=...`)
- Backend API returns `available: false` with all topics missing

**Check**:
```bash
# On Remote PC
ping 10.0.0.46
telnet 10.0.0.46 11311
```

---

### ❌ Issue 2: Topics Not Publishing

```
JETSON (10.0.0.46)
  ROS MASTER running ✓
  But sensors.launch NOT running ✗

  → No topics published
```

**Symptoms**:
- Network connection works
- `rostopic list` on Jetson shows no `/sensors/*` topics
- Backend correctly reports `available: false`

**Check**:
```bash
# On Jetson
rostopic list | grep sensors
# Should show 4+ sensor topics

# If empty, start sensors
roslaunch pyroscope_sensors sensors.launch
```

---

### ❌ Issue 3: Backend Can't Use rospy

```
REMOTE PC
  Backend running ✓
  Network to Jetson works ✓
  Topics publishing ✓
  But Python can't import rospy ✗
```

**Symptoms**:
- Everything works in terminal with `rostopic list`
- Backend API still returns `available: false`
- Backend logs show "rospy not available"

**Check**:
```bash
# On Remote PC, in backend directory
cd ~/Dev/pyroscope/application/backend
python -c "import rospy; print('OK')"
```

**Fix**: Use standalone `ros_sensor_bridge.py` script instead

---

### ❌ Issue 4: Wrong Jetson IP

```
REMOTE PC .env:
  ROS_MASTER_URI=http://10.0.0.46:11311  ✗ Wrong!

Actual Jetson IP changed to: 10.18.70.16
```

**Symptoms**:
- Backend can't reach ROS master
- Timeout errors

**Check**:
```bash
# On Jetson
hostname -I
# Compare to ROS_MASTER_URI in backend .env
```

**Fix**: Update `.env` file with correct IP

---

### ❌ Issue 5: Missing 1+ Topics

```
JETSON publishing:
  ✓ /sensors/sht40/temperature
  ✓ /sensors/sht40/humidity
  ✓ /sensors/thermal/mean
  ✗ /camera/color/image_raw    ← MISSING!
```

**Symptoms**:
- Backend returns `available: false`
- `missing_topics` array shows which ones

**Why**: Backend requires ALL 4 topics. Missing even 1 topic = unavailable.

**Check**:
```bash
# On Remote PC
export ROS_MASTER_URI=http://10.0.0.46:11311
rostopic list | grep -E "(temperature|humidity|thermal|color)"
```

**Fix**: Make sure RealSense camera is launched
```bash
# On Jetson
roslaunch realsense2_camera rs_camera.launch
```

---

## Diagnostic Decision Tree

```
Start: "sensors unavailable" showing on Mac
│
├─→ Can you ping Jetson from Remote PC?
│   │
│   ├─→ NO: Fix network/WiFi connection first
│   │
│   └─→ YES: Continue...
│       │
│       ├─→ Does `rostopic list` work on Jetson?
│       │   │
│       │   ├─→ NO: Start roscore on Jetson
│       │   │
│       │   └─→ YES: Continue...
│       │       │
│       │       ├─→ Do you see /sensors/* topics on Jetson?
│       │       │   │
│       │       │   ├─→ NO: Run `roslaunch pyroscope_sensors sensors.launch`
│       │       │   │
│       │       │   └─→ YES: Continue...
│       │       │       │
│       │       │       ├─→ Can Remote PC see topics?
│       │       │       │   (export ROS_MASTER_URI=... && rostopic list)
│       │       │       │   │
│       │       │       │   ├─→ NO: Check ROS_MASTER_URI IP in .env
│       │       │       │   │
│       │       │       │   └─→ YES: Continue...
│       │       │       │       │
│       │       │       │       ├─→ Does backend API return available=true?
│       │       │       │       │   (curl localhost:8000/api/sensors/availability)
│       │       │       │       │   │
│       │       │       │       │   ├─→ NO: Restart backend OR use standalone bridge
│       │       │       │       │   │
│       │       │       │       │   └─→ YES: Check frontend API URL matches backend IP
│       │       │       │       │
│       │       │       │       └─→ DONE: Should be working now!
```

---

## Quick Commands Reference

### On Jetson Nano:
```bash
# Check if topics publishing
rostopic list | grep sensors

# Start sensors if not running
roslaunch pyroscope_sensors sensors.launch

# Test individual topics
rostopic echo /sensors/sht40/temperature -n 1
```

### On Remote PC:
```bash
# Set ROS environment
export ROS_MASTER_URI=http://10.0.0.46:11311
export ROS_IP=10.0.0.170

# Check if can see Jetson topics
rostopic list | grep sensors

# Test backend API
curl http://localhost:8000/api/sensors/availability | python3 -m json.tool

# Run full diagnostic
cd ~/Dev/pyroscope/application/backend/scripts
./diagnose_sensor_availability.sh
```

### On Mac:
```bash
# Test from frontend perspective
curl http://10.18.50.245:8000/api/sensors/availability | python3 -m json.tool
```

---

## Expected Output When Working

### Backend API Response:
```json
{
  "available": true,
  "missing_topics": []
}
```

### Frontend Display:
```
┌─────────────────────────────┐
│ Live Sensors                │
│ sensors available 🟢        │  ← Green status
└─────────────────────────────┘
```

### ROS Topics on Jetson:
```
/sensors/sht40/humidity
/sensors/sht40/temperature
/sensors/thermal/image
/sensors/thermal/mean
/camera/color/image_raw
```

---

## Files Reference

| File | Purpose | Key Line |
|------|---------|----------|
| `backend/.env` | ROS config | Line 13: `ROS_MASTER_URI` |
| `backend/app/services/ros_sensor_bridge.py` | Topic checker | Line 237: `get_required_topics_status()` |
| | Required topics list | Line 17: `REQUIRED_SENSOR_TOPICS` |
| `backend/app/routers/sensors.py` | API endpoint | Line 60: `/api/sensors/availability` |
| `src/services/api.js` | Frontend API URL | Line 1: `API_BASE_URL` |
| `src/components/SensorPanel.jsx` | Status display | Line 54: Shows green/red status |

---

**TL;DR**: Frontend polls backend every 2 seconds. Backend checks if ALL 4 sensor topics exist on ROS master. If any topic missing or ROS unreachable → "sensors unavailable" 🔴
