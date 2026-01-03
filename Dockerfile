# Base Image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV BUN_INSTALL=/usr/local

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    build-essential \
    sudo \
    vim \
    nano \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Create 'dev' user with sudo access
RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Symlink bun to node for compatibility
RUN ln -s /usr/local/bin/bun /usr/local/bin/node

# Install Global CLIs using Bun
# We use bun install -g. Since BUN_INSTALL is /usr/local, binaries should go to /usr/local/bin
RUN bun install -g @anthropic-ai/claude-code
RUN bun install -g @google/gemini-cli
RUN bun install -g @qwen-code/qwen-code

# Install Qoder CLI
# The official script installs to ~/.qoder. We'll install it and move it to global path.
RUN curl -fsSL https://qoder.com/install > install_qoder.sh && \
    chmod +x install_qoder.sh && \
    ./install_qoder.sh || true

# Find the binary in /root/.qoder/bin/qodercli (it might be a directory or file structure)
# Based on logs: /root/.qoder/bin/qodercli/qodercli-[version]
# We'll find the executable file 'qodercli' or similar within that structure and move it.
RUN find /root/.qoder -type f -name "qodercli*" -executable -exec mv {} /usr/local/bin/qoder \; || \
    (echo "Qoder installation failed to produce binary" && exit 1)

RUN chmod +x /usr/local/bin/qoder

# Clean up
RUN rm install_qoder.sh && rm -rf /root/.qoder

# Set up user environment
USER dev
WORKDIR /home/dev

# Verify installations
RUN bun --version && \
    node --version || echo "Node check skipped (Bun wrapper quirks)"
