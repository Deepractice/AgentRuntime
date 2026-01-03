#
# Agent Runtime - Base execution environment for AI agents
# Debian 12 + Node.js 22 + Bun + Development tools
#

FROM debian:12

LABEL maintainer="Deepractice AI <hello@deepractice.ai>"
LABEL org.opencontainers.image.title="Agent Runtime"
LABEL org.opencontainers.image.description="Base runtime environment for AI agents with Debian, Node.js, Bun and essential tools"
LABEL org.opencontainers.image.version="1.2.0"

ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends -o Acquire::Retries=3 \
      # Network and certificates
      curl wget ca-certificates gnupg \
      # Process and system tools
      sudo procps vim nano less \
      # Version control
      git \
      # Build tools (for native Node.js modules)
      build-essential python3 python3-pip \
      # Additional utilities
      zip unzip jq htop tree && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 22 LTS
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install pnpm and promptx globally
RUN npm install -g pnpm@10.15.1 @promptx/cli

# Install Bun to /usr/local
ENV BUN_INSTALL=/usr/local
RUN curl -fsSL https://bun.sh/install | bash

# Verify installations
RUN node --version && \
    npm --version && \
    pnpm --version && \
    promptx --version && \
    bun --version && \
    git --version && \
    python3 --version

# Create node user (UID=1000 for host compatibility, optional use)
RUN useradd -u 1000 -U -m -s /bin/bash node && \
    echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Default work directory
WORKDIR /app

# Default user is root, users can switch with: USER node
CMD ["/bin/bash"]
