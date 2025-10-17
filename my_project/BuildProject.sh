#!/bin/bash
# Auto-detect OS and set paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PICO_SDK_PATH="$HOME/Pico_Programming/pico-sdk"
else
    export PICO_SDK_PATH="$HOME/Pico_Programming/pico-sdk"
fi

echo "🔨 Building my_project for board: "

cmake -B build -DPICO_BOARD=
cmake --build build --target my_project

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📁 UF2 file: build/my_project.uf2"
else
    echo "❌ Build failed"
    exit 1
fi
