# hermes-agent-docker

Minimal Docker image packaging for [Hermes Agent](https://github.com/NousResearch/hermes-agent).

## Image contents

The image in this repo:
- installs Hermes with the official upstream install script
- includes `mini-swe-agent`
- persists Hermes state under `/home/agent/.hermes`
- is intended for straightforward local builds and multi-arch publishing

## Quick start

### Build locally

```bash
docker build -t hermes-agent-docker:local .
```

### Run Hermes

Mount two paths:
- your current project into `/home/agent/workspace`
- a persistent Hermes home directory into `/home/agent/.hermes`

```bash
docker run --rm -it \
  -v "$PWD:/home/agent/workspace" \
  -v "$HOME/.hermes:/home/agent/.hermes" \
  hermes-agent-docker:local \
  hermes
```

### Run doctor

```bash
docker run --rm \
  -v "$HOME/.hermes:/home/agent/.hermes" \
  hermes-agent-docker:local \
  hermes doctor
```

## Persistence

Hermes stores config, sessions, memories, and related state in `/home/agent/.hermes` inside the container. Mount that path to keep state across runs.

On first start with an empty mounted `/home/agent/.hermes`, the container seeds that directory from image-prepared Hermes defaults before launching the requested command.

If you do not mount `/home/agent/.hermes`, Hermes will still start, but its state will be lost when the container exits.

## Environment and setup

Run `hermes setup` inside the container and persist `/home/agent/.hermes`, or place the expected config files inside that mounted directory.
