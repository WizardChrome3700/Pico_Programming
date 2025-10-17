#!/bin/bash

echo "🔧 Setting up Pico SDK development environment..."

# Detect OS and install dependencies
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS detected - installing dependencies via Homebrew..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found. Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install dependencies
    brew install cmake python3
    brew install --cask gcc-arm-embedded
    # Alternative: brew install arm-none-eabi-gcc arm-none-eabi-newlib
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Linux detected - installing dependencies via apt..."
    
    # Update package list
    sudo apt update
    
    # Install dependencies
    sudo apt install -y cmake python3 build-essential \
        gcc-arm-none-eabi libnewlib-arm-none-eabi \
        libstdc++-arm-none-eabi-newlib
    
else
    echo "❌ Unsupported OS: $OSTYPE"
    exit 1
fi

# Clone Pico SDK
echo "📥 Cloning Pico SDK..."
git clone https://github.com/raspberrypi/pico-sdk.git ~/Pico_Programming/pico-sdk

# Initialize submodules
echo "📦 Initializing submodules..."
cd ~/Pico_Programming/pico-sdk
git submodule update --init

echo "✅ Setup complete!"
echo "💡 Set environment variable:"
echo "   export PICO_SDK_PATH=~/Pico_Programming/pico-sdk"