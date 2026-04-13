# Stage 1 - Builder
FROM golang:1.24-alpine AS builder

ARG GREPAI_VERSION=main

RUN apk add --no-cache git

WORKDIR /src
RUN git clone --depth 1 --branch ${GREPAI_VERSION} https://github.com/yoanbernabeu/grepai.git .
RUN CGO_ENABLED=0 go build -ldflags "-s -w -X main.version=${GREPAI_VERSION}" -o /grepai ./cmd/grepai

# Stage 2 - Runtime
FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /grepai /grepai

USER 65534

WORKDIR /workspace

ENTRYPOINT ["/grepai"]
CMD ["watch", "--no-ui"]
