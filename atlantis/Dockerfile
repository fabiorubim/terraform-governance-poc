FROM ghcr.io/runatlantis/atlantis:latest

USER root

RUN apk add --no-cache curl unzip

ARG TARGETARCH

# Instala Terraform
RUN case "$TARGETARCH" in \
      amd64) ARCH=amd64 ;; \
      arm64) ARCH=arm64 ;; \
      *) exit 1 ;; \
    esac \
    && curl -fsSL \
      "https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_${ARCH}.zip" \
      -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip

# Instala OPA
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