# grepai-docker

Unofficial Docker image for [grepai](https://github.com/yoanbernabeu/grepai) — semantic code search CLI.

Uses a `FROM scratch` image (~30MB) containing only the static binary and CA certificates.

## Quick Start

### With Ollama (default)

```bash
docker run -v /path/to/project:/workspace \
  -e GREPAI_PROVIDER=ollama \
  -e GREPAI_ENDPOINT=http://host.docker.internal:11434 \
  ghcr.io/greite/grepai-docker
```

### With OpenAI

```bash
docker run -v /path/to/project:/workspace \
  -e GREPAI_PROVIDER=openai \
  -e GREPAI_API_KEY=sk-... \
  ghcr.io/greite/grepai-docker
```

### With OpenRouter

```bash
docker run -v /path/to/project:/workspace \
  -e GREPAI_PROVIDER=openrouter \
  -e GREPAI_API_KEY=sk-or-... \
  ghcr.io/greite/grepai-docker
```

### Running ad-hoc commands

```bash
docker run --rm --entrypoint /grepai ghcr.io/greite/grepai-docker version
```

## Environment Variables

On first run, `--auto-init` generates `.grepai/config.yaml` from these variables. If the config already exists, it is **not** overwritten.

### Embedder

| Variable | Config field | Default |
|---|---|---|
| `GREPAI_PROVIDER` | `embedder.provider` | `ollama` |
| `GREPAI_MODEL` | `embedder.model` | *(auto per provider)* |
| `GREPAI_ENDPOINT` | `embedder.endpoint` | *(auto per provider)* |
| `GREPAI_API_KEY` | `embedder.api_key` | *(empty)* |
| `GREPAI_DIMENSIONS` | `embedder.dimensions` | *(auto per provider)* |
| `GREPAI_PARALLELISM` | `embedder.parallelism` | `4` |

### Store

| Variable | Config field | Default |
|---|---|---|
| `GREPAI_BACKEND` | `store.backend` | `gob` |
| `GREPAI_POSTGRES_DSN` | `store.postgres.dsn` | `postgres://localhost:5432/grepai` |
| `GREPAI_QDRANT_ENDPOINT` | `store.qdrant.endpoint` | `localhost` |
| `GREPAI_QDRANT_PORT` | `store.qdrant.port` | `6334` |
| `GREPAI_QDRANT_COLLECTION` | `store.qdrant.collection` | *(auto)* |
| `GREPAI_QDRANT_API_KEY` | `store.qdrant.api_key` | *(empty)* |
| `GREPAI_QDRANT_USE_TLS` | `store.qdrant.use_tls` | `false` |

### Chunking

| Variable | Config field | Default |
|---|---|---|
| `GREPAI_CHUNKING_SIZE` | `chunking.size` | `512` |
| `GREPAI_CHUNKING_OVERLAP` | `chunking.overlap` | `50` |

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
