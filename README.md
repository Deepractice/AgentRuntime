# Agent Runtime

Base execution environment for AI agents.

## What's Inside

- **OS**: Debian 12
- **Node.js**: v20 LTS (with npm)
- **Package Manager**: pnpm 10.15.1
- **Browser**: Chromium with chromedriver
- **Media**: FFmpeg
- **Build Tools**: gcc, g++, make, python3 (for native modules)
- **Version Control**: git
- **Utilities**: curl, wget, vim, nano, jq, tree, htop

## Build

```bash
# Build latest version
./build.sh

# Build specific version
./build.sh 1.0.1
```

Or use GitHub Actions workflow (recommended):
1. Go to Actions tab
2. Select "Build and Push Docker Image"
3. Run workflow with version number

## Usage

### As Base Image

```dockerfile
FROM deepracticexs/agent-runtime:1.0.0

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

## Image Size

Approximately ~1.2GB (compressed ~450MB)

## Update Policy

- Rebuild when Node.js LTS version changes
- Rebuild when critical security updates available
- Version format: MAJOR.MINOR.PATCH

## Registry

Default: `docker.io/deepracticexs/agent-runtime`

Custom registry:

```bash
export REGISTRY=your-registry.com
./build.sh 1.0.0
```
