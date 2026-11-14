FROM ghcr.io/runatlantis/atlantis:latest

USER root

RUN apk add --no-cache curl

ARG TARGETARCH

RUN case "$TARGETARCH" in \
      amd64) ARCH=amd64 ;; \
      arm64) ARCH=arm64 ;; \
      *) exit 1 ;; \
    esac \
    && curl -fsSL \
      "https://openpolicyagent.org/downloads/latest/opa_linux_${ARCH}_static" \
      -o /usr/local/bin/opa \
    && chmod +x /usr/local/bin/opa

USER atlantis