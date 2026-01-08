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

## Claude Code

To authenticate Claude Code, usually you need to login via the browser flow that the CLI initiates, or set the API key.

```bash
claude login
```
or
```bash
export ANTHROPIC_API_KEY=your_key_here
```

## Gemini CLI

To authenticate Gemini CLI, use the login command or set the API key environment variable.

```bash
gemini login
```
or
```bash
export GEMINI_API_KEY=your_key_here
```
(Check `gemini --help` for specific env var names if different, e.g. `GOOGLE_API_KEY`).

## Qwen Code

To authenticate Qwen Code:

```bash
qwen login
```
or check documentation for environment variables (e.g. `DASHSCOPE_API_KEY`).

## Qoder

To authenticate Qoder:

```bash
qoder login
```
or follow the instructions provided by the tool upon first run.

## Atlassian CLI (acli)

To authenticate Atlassian CLI, you usually need to create a profile with your site URL and an API token.

```bash
acli login
```
Follow the interactive prompts or use the `acli profile` commands to manage multiple configurations.
For more details, visit: https://acli.atlassian.com/

## OpenAI Codex

To authenticate the OpenAI Codex agent:

```bash
codex login
```

or set your API key:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

To use the tool:
```bash
codex --help
```
