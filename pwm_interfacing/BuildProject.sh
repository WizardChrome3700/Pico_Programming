#!/bin/bash
export PICO_SDK_PATH="/home/akshat/Pico_Programming/pico-sdk"
PICO_TOOLS_DIR="/home/akshat/Pico_Programming/pico-sdk-tools"

export PICOTOOL_FETCH_FROM_GIT_PATH="/home/akshat/Pico_Programming/pico-tools"

# Find picotool
PICOTOOL=""
if command -v picotool &> /dev/null; then
    PICOTOOL="picotool"
elif [ -f "/home/akshat/Pico_Programming/pico-sdk-tools/build/picotool-install/picotool/picotool" ]; then
    PICOTOOL="/home/akshat/Pico_Programming/pico-sdk-tools/build/picotool-install/picotool/picotool"
fi

echo "🔨 Building pwm_interfacing for board: pico_w"

cmake -B build -DPICO_BOARD=pico_w
cmake --build build --target pwm_interfacing

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    UF2_FILE="build/pwm_interfacing.uf2"
    echo "📁 UF2 file: $UF2_FILE"
    
    if [ -n "$PICOTOOL" ]; then
        echo "📋 File info:"
        "$PICOTOOL" info "$UF2_FILE"
    fi
else
    echo "❌ Build failed"
    exit 1
fi
