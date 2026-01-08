# Base Image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV BUN_INSTALL=/usr/local
ENV PIPX_HOME=/usr/local/pipx
ENV PIPX_BIN_DIR=/usr/local/bin

# Install system dependencies
# Removed python/pipx as we are using Bun for the OpenAI tool
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    build-essential \
    sudo \
    vim \
    nano \
    ca-certificates \
    wget \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Install Atlassian CLI (acli)
RUN mkdir -p -m 755 /etc/apt/keyrings && \
    wget -nv -O- https://acli.atlassian.com/gpg/public-key.asc | gpg --dearmor -o /etc/apt/keyrings/acli-archive-keyring.gpg && \
    chmod go+r /etc/apt/keyrings/acli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/acli-archive-keyring.gpg] https://acli.atlassian.com/linux/deb stable main" | tee /etc/apt/sources.list.d/acli.list > /dev/null && \
    apt-get update && \
    apt-get install -y acli && \
    rm -rf /var/lib/apt/lists/*

# Create 'dev' user with sudo access
RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Symlink bun to node for compatibility
RUN ln -s /usr/local/bin/bun /usr/local/bin/node

# Install Global CLIs using Bun (Pinned Versions)
# We use bun install -g. Since BUN_INSTALL is /usr/local, binaries should go to /usr/local/bin
RUN bun install -g \
    @anthropic-ai/claude-code@2.1.1 \
    @google/gemini-cli@0.23.0 \
    @qwen-code/qwen-code@0.6.1 \
    @kilocode/cli@0.19.2 \
    cline@1.0.8 \
    @blackbox_ai/blackbox-cli@0.0.9 \
    @openai/codex@0.79.0

# Install Qoder CLI

# Install Qoder CLI
# The official script installs to ~/.qoder. We'll install it and move it to global path.
RUN curl -fsSL https://qoder.com/install > install_qoder.sh && \
    chmod +x install_qoder.sh && \
    ./install_qoder.sh || true

# Find the binary in /root/.qoder/bin/qodercli (it might be a directory or file structure)
# We'll find the executable file 'qodercli' or similar within that structure and move it.
RUN find /root/.qoder -type f -name "qodercli*" -executable -exec mv {} /usr/local/bin/qoder \; || \
    (echo "Qoder installation failed to produce binary" && exit 1)

RUN chmod +x /usr/local/bin/qoder

# Clean up
RUN rm install_qoder.sh && rm -rf /root/.qoder

# Add set-ai-cli script
COPY set-ai-cli.sh /usr/local/bin/set-ai-cli
RUN chmod +x /usr/local/bin/set-ai-cli

# Add Authentication instructions
COPY AUTHENTICATION.md /home/dev/AUTHENTICATION.md

# Set up user environment
USER dev
WORKDIR /home/dev

# Verify installations
RUN bun --version && \
    node --version || echo "Node check skipped (Bun wrapper quirks)"