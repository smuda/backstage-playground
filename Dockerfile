# Stage 1: Build
FROM node:22-bookworm-slim AS build

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3 \
      g++ \
      build-essential \
      libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json yarn.lock .yarnrc.yml backstage.json tsconfig.json ./
COPY .yarn .yarn
COPY packages/ packages/
COPY plugins/ plugins/

RUN corepack enable && \
    yarn install

RUN yarn tsc && \
    yarn build:backend

# Stage 2: Runtime
FROM node:22-bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3 \
      g++ \
      build-essential \
      libsqlite3-dev \
      python3-pip \
      python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --break-system-packages \
      mkdocs \
      mkdocs-techdocs-core

RUN corepack enable

USER node
WORKDIR /app

COPY --from=build --chown=node:node /app/.yarn .yarn
COPY --from=build --chown=node:node /app/.yarnrc.yml .yarnrc.yml
COPY --from=build --chown=node:node /app/backstage.json backstage.json
COPY --from=build --chown=node:node /app/yarn.lock ./
COPY --from=build --chown=node:node /app/package.json ./

ENV NODE_ENV=production
ENV NODE_OPTIONS="--no-node-snapshot"

COPY --from=build --chown=node:node /app/packages/backend/dist/skeleton.tar.gz ./
RUN tar xzf skeleton.tar.gz && rm skeleton.tar.gz

RUN yarn workspaces focus --all --production

COPY --chown=node:node examples ./examples

COPY --from=build --chown=node:node /app/packages/backend/dist/bundle.tar.gz ./
COPY --from=build --chown=node:node /app/app-config*.yaml ./
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

CMD ["node", "packages/backend", "--config", "app-config.yaml", "--config", "app-config.production.yaml"]
