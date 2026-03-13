# Diagram Selection Guide for Poster

All diagrams have been rendered in both PNG and SVG formats.

## ✅ Generated Files

### 1. **Pyroscope_Architecture_3_Devices** ⭐ RECOMMENDED FOR POSTER
- **Files**: `Pyroscope_Architecture_3_Devices.png` (270K), `.svg` (65K)
- **Source**: `01_architecture_3_devices.puml`
- **Best For**: Main architecture diagram on poster
- **Shows**:
  - Complete system across 3 devices (Jetson, Server, Mac)
  - All layers (Hardware → ROS → Integration → API → Frontend)
  - Data flow arrows with protocols
  - Color-coded components
  - Network communication (WiFi, HTTP, ROS)

**Use this for**: Primary architecture section of your poster

---

### 2. **Pyroscope_Mission_Flow** ⭐ RECOMMENDED FOR POSTER
- **Files**: `Pyroscope_Mission_Flow.png` (315K), `.svg` (40K)
- **Source**: `02_mission_flow_sequence.puml`
- **Best For**: "How It Works" section
- **Shows**:
  - Step-by-step mission execution
  - Timeline sequence from start to finish
  - Parallel processes (navigation, safety, sensors)
  - User interaction flow

**Use this for**: Explaining the mission workflow

---

### 3. **Network_Topology**
- **Files**: `Network_Topology.png` (181K), `.svg` (31K)
- **Source**: `05_network_topology.puml`
- **Best For**: System deployment section
- **Shows**:
  - Physical network layout
  - IP addresses and ports
  - Device connections
  - Network protocols

**Use this for**: Deployment/setup documentation

---

### 4. **Pyroscope_Layers_3_Devices**
- **Files**: `Pyroscope_Layers_3_Devices.png` (41K), `.svg` (8.3K)
- **Source**: `03_layers_3_devices.puml`
- **Best For**: Technical architecture overview
- **Shows**:
  - Layer-by-layer breakdown
  - Component relationships
  - Device assignment

**Use this for**: Detailed technical documentation

---

### 5. **Navigation_Control_Detail**
- **Files**: `Navigation_Control_Detail.png` (34K), `.svg` (7.8K)
- **Source**: `04_navigation_control_flow.puml`
- **Best For**: Algorithm explanation
- **Shows**:
  - ROS navigation control flow
  - Decision trees
  - PID control logic
  - Parallel process handling

**Use this for**: Deep-dive into navigation algorithm

---

## 🎯 Poster Recommendations

### Minimal Poster (1 diagram):
- **Use**: `Pyroscope_Architecture_3_Devices.svg`
- Covers entire system in one view

### Standard Poster (2 diagrams):
- **Primary**: `Pyroscope_Architecture_3_Devices.svg` (system overview)
- **Secondary**: `Pyroscope_Mission_Flow.svg` (how it works)

### Comprehensive Poster (3 diagrams):
- **Architecture**: `Pyroscope_Architecture_3_Devices.svg`
- **Mission Flow**: `Pyroscope_Mission_Flow.svg`
- **Deployment**: `Network_Topology.svg`

---

## 📐 File Format Guide

### PNG (Raster - 270K-315K)
- **Pros**: Works everywhere, easy preview
- **Cons**: Pixelated when zoomed/enlarged
- **Use for**: Digital displays, web viewing, quick previews

### SVG (Vector - 8K-65K)
- **Pros**: Scales infinitely, crisp at any size, smaller file
- **Cons**: Some software doesn't support SVG
- **Use for**: **Posters, presentations, printing** ⭐

---

## 🖨️ Importing to Poster Software

### PowerPoint
1. Insert → Pictures → From File
2. Select the `.svg` file
3. Resize as needed (maintains quality)

### Keynote (Mac)
1. File → Insert → Choose
2. Select the `.svg` file
3. Drag to resize

### Adobe Illustrator
1. File → Open
2. Select the `.svg` file
3. Edit as vector graphics

### Google Slides
1. Insert → Image → Upload from computer
2. Select the `.svg` file
3. May convert to PNG automatically

---

## 📍 Diagram Locations

All files are in: `~/Dev/pyroscope/docs/diagrams/`

```
docs/diagrams/
├── Pyroscope_Architecture_3_Devices.png  ← Main diagram PNG
├── Pyroscope_Architecture_3_Devices.svg  ← Main diagram SVG ⭐
├── Pyroscope_Mission_Flow.png
├── Pyroscope_Mission_Flow.svg            ⭐
├── Network_Topology.png
├── Network_Topology.svg
├── Pyroscope_Layers_3_Devices.png
├── Pyroscope_Layers_3_Devices.svg
├── Navigation_Control_Detail.png
└── Navigation_Control_Detail.svg
```

---

## 🎨 Color Legend

All diagrams use consistent color coding:

| Color | Component Type | Hex |
|-------|---------------|-----|
| 🔵 Blue | ROS Layer (Python 2, Jetson) | #BBDEFB |
| 🟡 Yellow | Backend API (Python 3, Server) | #FFF9C4 |
| 🩷 Pink | Frontend (React/JS, Client) | #F8BBD0 |
| 🟣 Purple | Data Storage | #E1BEE7 |
| 🟠 Orange | Hardware Sensors | #FFCCBC |

---

## ✨ Quick Tips

1. **Use SVG for printing** - They scale perfectly and look crisp
2. **Use PNG for quick sharing** - Everyone can view them
3. **Keep aspect ratio** - Don't stretch diagrams
4. **Add captions** - Explain what each diagram shows
5. **Reference in text** - "See Figure 1: System Architecture"

---

## 📝 Regenerating Diagrams

If you edit any `.puml` file:

```bash
cd ~/Dev/pyroscope/docs/diagrams
./render_all.sh
```

Or manually:
```bash
java -jar plantuml.jar -tsvg *.puml
```

---

Good luck with your poster presentation! 🚀
