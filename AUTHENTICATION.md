# AI CLI Authentication Guide

This guide explains how to authenticate the AI CLI tools installed in this container.

## Kilo Code

To authenticate Kilo Code, use the `config` command:

```bash
kilocode config
```

Alternatively, you can set the `KILO_API_KEY` environment variable.

## Cline

Cline is currently in preview as a CLI tool. Refer to the help command for the most up-to-date authentication methods:

```bash
cline --help
```

Usually, MCP-based tools or Anthropic-based tools may respect environment variables like `ANTHROPIC_API_KEY` if configured, or prompt for keys during first use.

## Blackbox AI

To authenticate Blackbox AI, run the main command and follow the prompts:

```bash
blackbox
```

You may be prompted to enter your API key or log in via a browser/dashboard URL.
