#!/bin/bash
# Script to render all PlantUML diagrams to PNG and SVG

echo "=========================================="
echo "Pyroscope Diagram Renderer"
echo "=========================================="
echo ""

# Check if PlantUML is installed
if ! command -v plantuml &> /dev/null; then
    echo "❌ PlantUML not found!"
    echo ""
    echo "Install with:"
    echo "  brew install plantuml"
    echo ""
    echo "Or use Docker:"
    echo "  docker run --rm -v \$(pwd):/data plantuml/plantuml *.puml"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "📁 Working directory: $SCRIPT_DIR"
echo ""

# Count .puml files
PUML_COUNT=$(ls -1 *.puml 2>/dev/null | wc -l)

if [ "$PUML_COUNT" -eq 0 ]; then
    echo "❌ No .puml files found in $SCRIPT_DIR"
    exit 1
fi

echo "Found $PUML_COUNT diagram(s) to render"
echo ""

# Render to PNG
echo "🖼️  Rendering to PNG..."
plantuml -tpng *.puml

if [ $? -eq 0 ]; then
    echo "✅ PNG files created"
else
    echo "❌ PNG rendering failed"
fi

echo ""

# Render to SVG (vector format for posters)
echo "🎨 Rendering to SVG..."
plantuml -tsvg *.puml

if [ $? -eq 0 ]; then
    echo "✅ SVG files created"
else
    echo "❌ SVG rendering failed"
fi

echo ""
echo "=========================================="
echo "✨ Rendering complete!"
echo "=========================================="
echo ""

# List generated files
echo "Generated files:"
ls -lh *.png *.svg 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'

echo ""
echo "📌 Tip: Use SVG files for high-quality posters"
echo ""
