# grepai-docker

Unofficial Docker image for [grepai](https://github.com/yoanbernabeu/grepai) — semantic code search CLI.

Uses a `FROM scratch` image (~30MB) containing only the static binary and CA certificates.

## Prerequisites

The project must have a `.grepai/config.yaml` before starting the container. Generate one with:

```bash
# In your project directory
grepai init
```

Or create it manually — see [configuration docs](https://github.com/yoanbernabeu/grepai#configuration).

## Quick Start

```bash
# Mount a project that already has .grepai/config.yaml
docker run -v /path/to/project:/workspace \
  ghcr.io/greite/grepai-docker
```

### Running ad-hoc commands

```bash
docker run --rm -v /path/to/project:/workspace \
  ghcr.io/greite/grepai-docker search "authentication flow"

docker run --rm ghcr.io/greite/grepai-docker version
```

## Docker Compose

```bash
docker compose --profile=watch up
```

See `compose.yaml` for examples with PostgreSQL and Qdrant backends.

## Build Locally

```bash
# Build from upstream main
docker build -t grepai .

# Build a specific version
docker build --build-arg GREPAI_VERSION=v0.35.0 -t grepai .

# Multi-arch
docker buildx build --platform linux/amd64,linux/arm64 -t grepai .
```

## License

This Docker packaging is MIT licensed. grepai itself is [MIT licensed](https://github.com/yoanbernabeu/grepai/blob/main/LICENSE).
