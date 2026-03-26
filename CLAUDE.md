# Backstage Playground

## Overview

Offline-ready Backstage dev environment using
Docker Compose. No host Node.js required — everything
builds and runs inside containers.

## Project Structure

```
.
├── Dockerfile              # Multi-stage build (node:22)
├── docker-compose.yml      # Backstage + PostgreSQL
├── app-config.yaml         # Dev config (SQLite, local)
├── app-config.production.yaml  # Docker config (Postgres)
├── packages/
│   ├── app/                # Frontend (React)
│   └── backend/            # Backend (Node.js)
├── plugins/                # Custom plugins (empty)
├── examples/
│   ├── entities.yaml       # Catalog: systems, components, APIs
│   ├── org.yaml            # Catalog: users, groups
│   ├── template/           # Scaffolder template
│   └── example-docs/       # TechDocs (mkdocs)
└── offline-docs/           # Mirrored backstage.io docs
```

## Running

```bash
docker compose up        # Start (localhost:7007)
docker compose down      # Stop
docker compose build     # Rebuild after changes
```

Login with **guest** auth — no external services needed.

## Offline Docs

Open `offline-docs/backstage.io/docs/index.html`
in a browser.

## Key Config Choices

- **Auth**: Guest (no GitHub/external provider)
- **Database**: PostgreSQL 16 via Docker
- **TechDocs**: Local generator (mkdocs in image)
- **Catalog**: File-based, local only
- **Node**: 22 (inside Docker only — host version
  does not matter)

## Adding Catalog Entities

Edit files in `examples/` and restart. The catalog
auto-refreshes from file locations defined in
`app-config.yaml` under `catalog.locations`.

## Rebuilding the Docker Image

Required after changing `packages/` source code:

```bash
docker compose build --no-cache
docker compose up
```

Config-only changes (`app-config*.yaml`, `examples/`)
are volume-mounted and take effect on restart.
