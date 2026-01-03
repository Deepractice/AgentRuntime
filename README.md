# Agent Runtime

Base execution environment for AI agents.

## What's Inside

- **OS**: Debian 12
- **Node.js**: v22 LTS (with npm)
- **Bun**: Latest version
- **Package Manager**: pnpm 10.15.1
- **PromptX**: @promptx/cli (promptx command)
- **Build Tools**: gcc, g++, make, python3 (for native modules)
- **Version Control**: git
- **Utilities**: curl, wget, vim, nano, jq, tree, htop

## Build

```bash
# Build latest version
./build.sh

# Build specific version
./build.sh 0.4.0
```

Or use GitHub Actions workflow (recommended):
1. Go to Actions tab
2. Select "Build and Push Docker Image"
3. Run workflow with version number

## Usage

### As Base Image

```dockerfile
FROM deepracticexs/agent-runtime:0.4.0

# Your application code
WORKDIR /app
COPY . .
RUN pnpm install
CMD ["node", "index.js"]
```

### Interactive Shell

```bash
docker run -it --rm deepracticexs/agent-runtime:latest
```

### Run as Non-root User

```bash
docker run -it --rm --user node deepracticexs/agent-runtime:latest
```

Or in Dockerfile:

```dockerfile
FROM deepracticexs/agent-runtime:0.4.0
USER node
```

## Image Size

Approximately ~1.6GB (compressed ~500MB)

## Update Policy

- Rebuild when Node.js LTS version changes
- Rebuild when critical security updates available
- Version format: MAJOR.MINOR.PATCH

## Registry

Default: `docker.io/deepracticexs/agent-runtime`

Custom registry:

```bash
export REGISTRY=your-registry.com
./build.sh 0.4.0
```
