# Pyroscope Architecture Diagrams

This directory contains PlantUML diagrams documenting the Pyroscope system architecture.

## Diagram Files

| File | Description | Best For |
|------|-------------|----------|
| `01_architecture_3_devices.puml` | Complete system architecture across 3 devices with data flow | **Main poster diagram** - Shows entire system |
| `02_mission_flow_sequence.puml` | Mission execution sequence diagram | Explaining "How missions work" |
| `03_layers_3_devices.puml` | System layers and component breakdown | Technical architecture overview |
| `04_navigation_control_flow.puml` | Detailed ROS navigation control flow | Understanding navigation algorithm |
| `05_network_topology.puml` | Network layout and communication | Deployment and network setup |

---

## How to Render Diagrams

### Method 1: Online Renderer (Easiest)

1. Go to: https://www.plantuml.com/plantuml/uml/
2. Copy and paste the contents of any `.puml` file
3. Click "Submit" to generate the diagram
4. Right-click the image → "Save Image As..."

### Method 2: Command Line (Mac)

#### Install PlantUML:
```bash
# Install Java (required)
brew install openjdk

# Install PlantUML
brew install plantuml
```

#### Generate PNG images:
```bash
# Navigate to diagrams directory
cd ~/Dev/pyroscope/docs/diagrams

# Render all diagrams to PNG
plantuml *.puml

# Render specific diagram
plantuml 01_architecture_3_devices.puml

# Render to SVG (vector, better for posters)
plantuml -tsvg 01_architecture_3_devices.puml

# Render high-res PNG
plantuml -tpng 01_architecture_3_devices.puml
```

This will create `.png` or `.svg` files in the same directory.

### Method 3: VS Code Extension

1. Install extension: "PlantUML" by jebbs
2. Install Java: `brew install openjdk`
3. Open any `.puml` file
4. Press `Option+D` (Mac) or `Alt+D` (Windows) to preview
5. Right-click preview → Export to PNG/SVG

### Method 4: Docker (No installation needed)

```bash
# Run PlantUML in Docker
docker run --rm -v $(pwd):/data plantuml/plantuml *.puml

# This generates PNG files for all .puml files
```

---

## Output Files

After rendering, you'll get:

```
docs/diagrams/
├── 01_architecture_3_devices.puml
├── 01_architecture_3_devices.png          ← Generated
├── 02_mission_flow_sequence.puml
├── 02_mission_flow_sequence.png           ← Generated
├── 03_layers_3_devices.puml
├── 03_layers_3_devices.png                ← Generated
├── 04_navigation_control_flow.puml
├── 04_navigation_control_flow.png         ← Generated
├── 05_network_topology.puml
├── 05_network_topology.png                ← Generated
└── README.md
```

**Note**: `.png` and `.svg` files are ignored by git (add to `.gitignore` if needed).

---

## Recommended Diagrams for Poster

### Main Architecture Diagram
**Use**: `01_architecture_3_devices.puml`
- Shows complete system with all layers
- Clear device boundaries (Jetson, Server, Mac)
- Data flow arrows with protocols
- Color-coded by layer type

### Mission Flow Diagram
**Use**: `02_mission_flow_sequence.puml`
- Step-by-step mission execution
- Timeline-based sequence
- Shows parallel processes (navigation, safety, sensors)

### Network Diagram
**Use**: `05_network_topology.puml`
- Physical network layout
- IP addresses and ports
- Good for deployment section

---

## Customization

### Change Colors

Edit the color definitions at the top of each file:

```plantuml
!define ROS_COLOR #BBDEFB      ← ROS Layer (Blue)
!define API_COLOR #FFF9C4      ← Backend API (Yellow)
!define WEB_COLOR #F8BBD0      ← Frontend (Pink)
!define DATA_COLOR #E1BEE7     ← Data Storage (Purple)
!define SENSOR_COLOR #FFCCBC   ← Hardware (Orange)
```

### Adjust Layout

- Add `left to right direction` after `@startuml` for horizontal layout
- Use `skinparam` commands to change fonts, sizes, spacing
- See PlantUML documentation: https://plantuml.com/

---

## Exporting for Poster

### For High-Quality Prints:

1. **SVG (Vector)** - Best for posters
   ```bash
   plantuml -tsvg 01_architecture_3_devices.puml
   ```
   - Scales to any size without quality loss
   - Can be edited in Illustrator/Inkscape

2. **High-DPI PNG**
   ```bash
   # Generate with custom DPI
   plantuml -DPLANTUML_LIMIT_SIZE=16384 -tpng 01_architecture_3_devices.puml
   ```

3. **Import to PowerPoint/Keynote**
   - Use SVG for best quality
   - Or use high-res PNG (at least 300 DPI)

---

## Color Legend

| Color | Meaning | Hex Code |
|-------|---------|----------|
| Blue | ROS Layer (Python 2, Jetson) | #BBDEFB |
| Yellow | Backend API (Python 3, Server) | #FFF9C4 |
| Pink | Frontend (React/JS, Client) | #F8BBD0 |
| Purple | Data Storage (Files, Database) | #E1BEE7 |
| Orange | Hardware Sensors | #FFCCBC |
| Green | Device Containers | #E8F5E9 |

---

## Troubleshooting

### "Command not found: plantuml"
- Install PlantUML: `brew install plantuml`
- Or use online renderer

### "Java not found"
- Install Java: `brew install openjdk`

### Diagram doesn't render
- Check syntax with online validator
- Look for missing `@enduml` tag
- Check for unmatched quotes or parentheses

### Image is too small/blurry
- Use SVG format instead of PNG
- Or increase PNG resolution with `-DPLANTUML_LIMIT_SIZE` flag

---

## Resources

- **PlantUML Official Docs**: https://plantuml.com/
- **Component Diagrams**: https://plantuml.com/component-diagram
- **Sequence Diagrams**: https://plantuml.com/sequence-diagram
- **Activity Diagrams**: https://plantuml.com/activity-diagram-beta
- **Online Editor**: https://www.plantuml.com/plantuml/uml/

---

## Questions?

For issues with the diagrams or to request modifications, contact the repository maintainer.
