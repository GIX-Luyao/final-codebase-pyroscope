# 🎯 Simplified Poster Diagrams - Selection Guide

These diagrams are specifically designed for **poster presentations** with:
- ✅ **Large fonts** (readable from 6 feet away)
- ✅ **Clear visual hierarchy** (eyes naturally guided)
- ✅ **Minimal text** (scannable in seconds)
- ✅ **High contrast colors** (easy to distinguish)
- ✅ **White space** (not overwhelming)

---

## 📊 Available Simplified Diagrams

### 🏆 **RECOMMENDED: Simple_Architecture.svg**
**File**: `Simple_Architecture.svg` / `Simple_Architecture.png`
**Best For**: Main architecture overview on poster

**What It Shows**:
- 3 big boxes: Robot → Server → Dashboard
- Clear data flow arrows with labels
- Technology stack for each component
- Emphasizes the 3-device architecture

**Why It's Better**:
- ✅ **Not cluttered** - Only 3 main components
- ✅ **Large text** - All labels 14-24pt
- ✅ **Clear flow** - Bidirectional arrows show communication
- ✅ **Color coded** - Blue (robot), Yellow (server), Pink (web)

**Use When**: You need to explain the overall system in ONE glance

---

### 🥈 **RECOMMENDED: Overview_Simple.svg**
**File**: `Overview_Simple.svg` / `Overview_Simple.png`
**Best For**: Executive summary / high-level view

**What It Shows**:
- 4 key concepts: Autonomous Robot → Coverage Mission → Data Analysis → Web Dashboard
- Circular flow showing the complete loop
- Bottom note explaining the innovation

**Why It's Better**:
- ✅ **Big picture focus** - Shows workflow, not technical details
- ✅ **Story-driven** - Follows the user journey
- ✅ **Key innovation highlighted** - Bottom note emphasizes autonomous scanning

**Use When**: Audience is non-technical or you want to lead with impact

---

### 🥉 **Mission_Flow_Simple.svg**
**File**: `Mission_Flow_Simple.svg` / `Mission_Flow_Simple.png`
**Best For**: "How It Works" section

**What It Shows**:
- 6 numbered steps from mission start to completion
- Circular symbols (①②③) guide the eye
- Legend at bottom highlights key features

**Why It's Better**:
- ✅ **Sequential** - Easy to follow top-to-bottom
- ✅ **Numbered** - Clear progression
- ✅ **Two-level detail** - Bold step names + smaller descriptions

**Use When**: You need to explain the mission execution process

---

### **System_Layers_Simple.svg**
**File**: `System_Layers_Simple.svg` / `System_Layers_Simple.png`
**Best For**: Technical architecture breakdown

**What It Shows**:
- 4 layers: Web → Application → Robot Control → Hardware
- Top-down stack showing data flow
- Side notes explain user interaction and autonomy

**Why It's Better**:
- ✅ **Layered** - Clear separation of concerns
- ✅ **Technology labeled** - Shows tech stack at each layer
- ✅ **Notes** - Highlights key features without cluttering main diagram

**Use When**: Technical audience wants to understand the software stack

---

### **Data_Flow_Simple.svg**
**File**: `Data_Flow_Simple.svg` / `Data_Flow_Simple.png`
**Best For**: Data pipeline explanation

**What It Shows**:
- 3 entities: Sensors → Database → Operator
- Triangular flow with numbered steps
- Focus on real-time data streaming

**Why It's Better**:
- ✅ **Minimal** - Only 3 components
- ✅ **Visual icons** - Emojis help quick identification
- ✅ **Emphasizes real-time** - Legend highlights continuous updates

**Use When**: You want to emphasize the data collection aspect

---

## 🎨 Visual Design Principles Used

### Font Sizes
- **Title**: 28-32pt (huge, instant read)
- **Component Names**: 22-28pt (bold, main focus)
- **Descriptions**: 14-18pt (readable details)
- **Arrows**: 18-20pt (clear flow labels)

### Colors (Same as Before)
- 🔵 **Blue #BBDEFB** - Robot/ROS layer
- 🟡 **Yellow #FFF9C4** - Backend/Server
- 🩷 **Pink #F8BBD0** - Frontend/User interface
- 🟠 **Orange #FFCCBC** - Hardware/Sensors
- 🟣 **Purple #E1BEE7** - Data storage

### Layout
- **White space**: 30-40% of diagram is empty
- **Arrow thickness**: 4-6px (highly visible)
- **Border thickness**: 3-4px (clear boundaries)

---

## 📐 Poster Layout Recommendations

### Option A: Single Main Diagram (Minimal Poster)
```
┌─────────────────────────────────────┐
│         POSTER TITLE                │
├─────────────────────────────────────┤
│                                     │
│   Simple_Architecture.svg           │
│   (Centered, large)                 │
│                                     │
├─────────────────────────────────────┤
│   Text: Problem, Solution, Impact  │
└─────────────────────────────────────┘
```
**Best for**: Limited space, focus on architecture

---

### Option B: Two Diagrams (Recommended)
```
┌─────────────────────────────────────┐
│         POSTER TITLE                │
├──────────────────┬──────────────────┤
│                  │                  │
│ Overview_Simple  │ Mission_Flow     │
│     (Left)       │   _Simple        │
│                  │   (Right)        │
│                  │                  │
├──────────────────┴──────────────────┤
│   Text: Methods, Results            │
└─────────────────────────────────────┘
```
**Best for**: Balanced - shows both WHAT and HOW

---

### Option C: Three Diagrams (Comprehensive)
```
┌─────────────────────────────────────┐
│         POSTER TITLE                │
├─────────────────────────────────────┤
│   Overview_Simple (Top, Centered)   │
├──────────────────┬──────────────────┤
│                  │                  │
│ Simple_          │ Mission_Flow     │
│ Architecture     │ _Simple          │
│                  │                  │
├──────────────────┴──────────────────┤
│   Text: Results, Discussion         │
└─────────────────────────────────────┘
```
**Best for**: Detailed poster with multiple sections

---

## 🔄 Comparison: Old vs New Diagrams

### OLD (Original Complex Diagrams)
```
Pyroscope_Architecture_3_Devices.svg
```
- ❌ 50+ labeled components
- ❌ Small fonts (8-12pt)
- ❌ Dense connections (20+ arrows)
- ❌ Hard to read from distance
- ✅ Shows EVERYTHING (good for documentation)

### NEW (Simplified Poster Diagrams)
```
Simple_Architecture.svg
```
- ✅ 3 main components
- ✅ Large fonts (14-28pt)
- ✅ 4 clear arrows
- ✅ Readable from 10 feet away
- ✅ Shows KEY CONCEPTS (good for posters)

---

## 🎯 Quick Selection Guide

**If you can only use ONE diagram:**
→ Use `Simple_Architecture.svg`

**If your audience is non-technical:**
→ Use `Overview_Simple.svg`

**If you need to explain the workflow:**
→ Use `Mission_Flow_Simple.svg`

**If you want technical + workflow:**
→ Use `Simple_Architecture.svg` + `Mission_Flow_Simple.svg`

**If space is limited:**
→ Use `Overview_Simple.svg` (most compact, highest impact)

---

## 📏 Sizing Recommendations for Poster

### For 36" × 48" Poster
- Each diagram: **~16" wide**
- Leave **2-3" margins**
- Title text: **3-4" tall**

### For 24" × 36" Poster
- Each diagram: **~12" wide**
- Leave **1.5-2" margins**
- Title text: **2-3" tall**

**Pro tip**: SVG scales perfectly - just resize in PowerPoint/Keynote without quality loss!

---

## ✅ Final Checklist

Before finalizing your poster:
- [ ] Can you read all text from 6 feet away?
- [ ] Is the main message clear in <5 seconds?
- [ ] Do colors guide the eye through the flow?
- [ ] Is there enough white space (not cramped)?
- [ ] Are you using SVG format for printing?

---

## 📂 File Locations

All simplified diagrams are in:
```
~/Dev/pyroscope/docs/diagrams/
```

**Source files** (editable):
- `POSTER_01_simple_architecture.puml`
- `POSTER_02_mission_flow.puml`
- `POSTER_03_system_layers.puml`
- `POSTER_04_data_flow.puml`
- `POSTER_05_overview.puml`

**Rendered files** (ready to use):
- `Simple_Architecture.svg` ⭐
- `Mission_Flow_Simple.svg` ⭐
- `System_Layers_Simple.svg`
- `Data_Flow_Simple.svg`
- `Overview_Simple.svg` ⭐

---

## 🎨 Need to Customize?

Edit the `.puml` source files and change:

**Make text bigger:**
```plantuml
skinparam defaultFontSize 24  ← Increase this
```

**Change colors:**
```plantuml
#BBDEFB  ← Change to any hex color
```

**Adjust spacing:**
```plantuml
scale 2.5  ← Increase for more white space
```

Then re-render:
```bash
java -jar plantuml.jar -tsvg POSTER_*.puml
```

---

Good luck with your poster! The simplified diagrams should be much more readable and eye-catching. 🚀
