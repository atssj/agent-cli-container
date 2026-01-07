#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: set-ai-cli <tool>"
    echo "Available tools:"
    echo "  kilo     - Set Kilo Code as default (kilocode)"
    echo "  cline    - Set Cline as default (cline)"
    echo "  blackbox - Set Blackbox as default (blackbox)"
    echo "  claude   - Set Claude Code as default (claude)"
    echo "  gemini   - Set Gemini CLI as default (gemini)"
    echo "  qwen     - Set Qwen Code as default (qwen)"
    echo "  qoder    - Set Qoder as default (qoder)"
    exit 1
}

# Check if argument is provided
if [ -z "$1" ]; then
    usage
fi

TOOL=$1

# Determine the binary path based on the tool
case $TOOL in
    kilo)
        BINARY_PATH=$(which kilocode)
        TOOL_NAME="Kilo Code"
        ;;
    cline)
        BINARY_PATH=$(which cline)
        TOOL_NAME="Cline"
        ;;
    blackbox)
        BINARY_PATH=$(which blackbox)
        TOOL_NAME="Blackbox"
        ;;
    claude)
        BINARY_PATH=$(which claude)
        TOOL_NAME="Claude Code"
        ;;
    gemini)
        BINARY_PATH=$(which gemini)
        TOOL_NAME="Gemini CLI"
        ;;
    qwen)
        BINARY_PATH=$(which qwen)
        TOOL_NAME="Qwen Code"
        ;;
    qoder)
        BINARY_PATH=$(which qoder)
        TOOL_NAME="Qoder"
        ;;
    *)
        echo "Error: Unknown tool '$TOOL'"
        usage
        ;;
esac

# Check if the binary exists
if [ -z "$BINARY_PATH" ]; then
    echo "Error: $TOOL_NAME binary not found."
    exit 1
fi

# Create/Update the symlink
# Note: This might require sudo if /usr/local/bin is owned by root,
# but the user 'dev' has NOPASSWD sudo access.
sudo ln -sf "$BINARY_PATH" /usr/local/bin/ai

echo "Default AI CLI set to $TOOL_NAME"
echo "You can now use 'ai' to run it."
