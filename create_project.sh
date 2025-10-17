# #!/bin/bash

# PROJECT_NAME=${1:-"my_project"}
# BOARD_NAME=${2:-""}

# # Set SDK path based on OS
# if [[ "$OSTYPE" == "darwin"* ]]; then
#     SDK_PATH="$HOME/Pico_Programming/pico-sdk"
#     SHELL_RC="$HOME/.zshrc"
#     echo "🍎 macOS detected"
# else
#     SDK_PATH="$HOME/Pico_Programming/pico-sdk"
#     SHELL_RC="$HOME/.bashrc"
#     echo "🐧 Linux detected"
# fi

# # Check if SDK exists
# if [ ! -d "$SDK_PATH" ]; then
#     echo "❌ Pico SDK not found at: $SDK_PATH"
#     echo "💡 Please run the installation script first"
#     exit 1
# fi

# # Create project folder
# mkdir -p "$PROJECT_NAME"

# # Copy required files
# cp "$SDK_PATH/external/pico_sdk_import.cmake" "./$PROJECT_NAME/"

# # Create main.c
# cat > "$PROJECT_NAME/main.c" << 'EOF'
# #include <stdio.h>
# #include "pico/stdlib.h"

# int main()
# {
#     stdio_init_all();
#     printf("Hello world!\n");
#     return 0;
# }
# EOF

# # Create CMakeLists.txt
# cat > "$PROJECT_NAME/CMakeLists.txt" << EOF
# cmake_minimum_required(VERSION 3.13...3.27)
# include(pico_sdk_import.cmake)
# project($PROJECT_NAME)
# pico_sdk_init()
# add_executable($PROJECT_NAME main.c)
# target_link_libraries($PROJECT_NAME pico_stdlib)
# pico_enable_stdio_usb($PROJECT_NAME 1)
# pico_enable_stdio_uart($PROJECT_NAME 0)
# pico_add_extra_outputs($PROJECT_NAME)
# EOF

# # Create OS-aware BuildProject.sh
# cat > "$PROJECT_NAME/BuildProject.sh" << EOF
# #!/bin/bash
# # Auto-detect OS and set paths
# if [[ "\$OSTYPE" == "darwin"* ]]; then
#     export PICO_SDK_PATH="\$HOME/Pico_Programming/pico-sdk"
# else
#     export PICO_SDK_PATH="\$HOME/Pico_Programming/pico-sdk"
# fi

# echo "🔨 Building $PROJECT_NAME for board: $BOARD_NAME"

# cmake -B build -DPICO_BOARD=$BOARD_NAME
# cmake --build build --target $PROJECT_NAME

# if [ \$? -eq 0 ]; then
#     echo "✅ Build successful!"
#     echo "📁 UF2 file: build/$PROJECT_NAME.uf2"
# else
#     echo "❌ Build failed"
#     exit 1
# fi
# EOF

# chmod +x "$PROJECT_NAME/BuildProject.sh"

# echo "✅ Project '$PROJECT_NAME' created successfully!"
# echo "📁 Location: $PROJECT_NAME/"
# echo "🔨 Build with: cd $PROJECT_NAME && ./BuildProject.sh"
# cd ./$PROJECT_NAME

#!/bin/bash

PROJECT_NAME=${1:-"my_project"}
BOARD_NAME=${2:-"pico"}  # Default to pico if not specified

# Set SDK path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    SDK_PATH="$HOME/Pico_Programming/pico-sdk"
    SHELL_RC="$HOME/.zshrc"
    echo "🍎 macOS detected"
else
    SDK_PATH="$HOME/Pico_Programming/pico-sdk"
    SHELL_RC="$HOME/.bashrc"
    echo "🐧 Linux detected"
fi

# Check if SDK exists
if [ ! -d "$SDK_PATH" ]; then
    echo "❌ Pico SDK not found at: $SDK_PATH"
    echo "💡 Please run the installation script first"
    exit 1
fi

# Create project folder
mkdir -p "$PROJECT_NAME"

# Copy required files
cp "$SDK_PATH/external/pico_sdk_import.cmake" "./$PROJECT_NAME/"

# Create main.c
cat > "$PROJECT_NAME/main.c" << 'EOF'
#include <stdio.h>
#include "pico/stdlib.h"

int main()
{
    stdio_init_all();
    printf("Hello world!\n");
    return 0;
}
EOF

# Create CMakeLists.txt
cat > "$PROJECT_NAME/CMakeLists.txt" << EOF
cmake_minimum_required(VERSION 3.13...3.27)
include(pico_sdk_import.cmake)
project($PROJECT_NAME)
pico_sdk_init()
add_executable($PROJECT_NAME main.c)
target_link_libraries($PROJECT_NAME pico_stdlib)
pico_enable_stdio_usb($PROJECT_NAME 1)
pico_enable_stdio_uart($PROJECT_NAME 0)
pico_add_extra_outputs($PROJECT_NAME)
EOF

# Create BuildProject.sh with picotool support
cat > "$PROJECT_NAME/BuildProject.sh" << EOF
#!/bin/bash
export PICO_SDK_PATH="$SDK_PATH"
PICO_TOOLS_DIR="$HOME/Pico_Programming/pico-sdk-tools"

export PICOTOOL_FETCH_FROM_GIT_PATH="$HOME/Pico_Programming/pico-tools"

# Find picotool
PICOTOOL=""
if command -v picotool &> /dev/null; then
    PICOTOOL="picotool"
elif [ -f "$HOME/Pico_Programming/pico-sdk-tools/build/picotool-install/picotool/picotool" ]; then
    PICOTOOL="$HOME/Pico_Programming/pico-sdk-tools/build/picotool-install/picotool/picotool"
fi

echo "🔨 Building $PROJECT_NAME for board: $BOARD_NAME"

cmake -B build -DPICO_BOARD=$BOARD_NAME
cmake --build build --target $PROJECT_NAME

if [ \$? -eq 0 ]; then
    echo "✅ Build successful!"
    UF2_FILE="build/$PROJECT_NAME.uf2"
    echo "📁 UF2 file: \$UF2_FILE"
    
    if [ -n "\$PICOTOOL" ]; then
        echo "📋 File info:"
        "\$PICOTOOL" info "\$UF2_FILE"
    fi
else
    echo "❌ Build failed"
    exit 1
fi
EOF

chmod +x "$PROJECT_NAME/BuildProject.sh"

echo "✅ Project '$PROJECT_NAME' created successfully!"
echo "📁 Location: $PROJECT_NAME/"
echo "🔨 Build with: cd $PROJECT_NAME && ./BuildProject.sh"