#!/bin/bash

echo "🔧 Setting up Pico tools..."

PICO_TOOLS_DIR="$HOME/Pico_Programming/pico-sdk-tools"

export PICOTOOL_FETCH_FROM_GIT_PATH="$HOME/Pico_Programming/pico-tools"

# # Method 1: Create symlinks (most reliable)
echo "🔗 Creating symlinks for Pico tools..."
sudo ln -sf "$PICO_TOOLS_DIR/build/picotool-install/picotool/picotool" /usr/local/bin/picotool 2>/dev/null
# Make your v2.2.0 appear as v2.1.1
sudo ln -sf /usr/local/bin/picotool /usr/local/bin/picotool-2.1.1

# Also set up openocd if it exists
if [ -f "$PICO_TOOLS_DIR/build/openocd-install/usr/local/bin/openocd" ]; then
    sudo ln -sf "$PICO_TOOLS_DIR/build/openocd-install/usr/local/bin/openocd" /usr/local/bin/openocd 2>/dev/null
fi

# Method 2: Also add to PATH as backup
echo "🛠️ Adding to PATH as backup..."
sed -i '/Pico_Programming\/pico-sdk-tools/d' ~/.bashrc
echo 'export PATH="$HOME/Pico_Programming/pico-sdk-tools/build/picotool-install/picotool:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/Pico_Programming/pico-sdk-tools/build/openocd-install/usr/local/bin:$PATH"' >> ~/.bashrc

# Source the updated bashrc
source ~/.bashrc

echo "✅ Pico tools setup complete!"
echo "📋 Available tools:"

# Test picotool
if command -v picotool &> /dev/null; then
    echo "🎉 Picotool: $(picotool version 2>/dev/null | head -1)"
else
    echo "❌ Picotool not found"
    # Show debugging info
    echo "   Debug: Checking paths..."
    ls -la "$PICO_TOOLS_DIR/build/picotool-install/picotool/picotool" 2>/dev/null && echo "   Binary exists but not in PATH"
fi

# Test openocd
if command -v openocd &> /dev/null; then
    echo "🎉 OpenOCD: $(openocd --version 2>/dev/null | head -1)"
else
    echo "⚠️  OpenOCD not found (optional)"
fi

echo ""
echo "💡 You can now use 'picotool' from any directory!"