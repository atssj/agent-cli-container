# agent-cli-container

A portable Docker environment for AI-assisted development, pre-loaded with powerful CLI tools.

## 🚀 Features

*   **Base:** Ubuntu 24.04 LTS
*   **User:** `dev` (with sudo access)
*   **Runtime:** Bun (Javascript Runtime & Package Manager)
*   **Included Tools:**
    *   `bun` - Fast JavaScript runtime
    *   `claude` - Anthropic's AI coding assistant
    *   `gemini` - Google's Gemini CLI
    *   `qwen` - Alibaba's Qwen Code CLI
    *   `qoder` - Qoder AI Agent CLI

## 🛠️ Usage

### Pulling the Image

```bash
docker pull ghcr.io/<your-username>/agent-cli-container:latest
```

### Running the Container

```bash
docker run -it --rm \
  -v $(pwd):/home/dev/workspace \
  ghcr.io/<your-username>/agent-cli-container:latest
```

### Authentication

Most tools require authentication. You can pass API keys as environment variables or configure them interactively.

**Example with Environment Variables:**

```bash
docker run -it --rm \
  -e ANTHROPIC_API_KEY=your_key \
  -e GOOGLE_API_KEY=your_key \
  ghcr.io/<your-username>/agent-cli-container:latest
```

## 🏗️ Build Locally

To build the image locally:

```bash
docker build -t agent-cli-container .
```

To run the local build:

```bash
docker run -it --rm agent-cli-container
```

## 📦 Installed CLIs

*   **Bun:** `bun --version`
*   **Claude Code:** `claude --version`
*   **Gemini CLI:** `gemini --version`
*   **Qwen Code:** `qwen --version`
*   **Qoder:** `qoder --version`

## 🤝 Contributing

1.  Fork the repository.
2.  Create a feature branch.
3.  Commit your changes.
4.  Push to the branch.
5.  Open a Pull Request.
