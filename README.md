# Backstage Playground

Offline-ready [Backstage](https://backstage.io)
dev environment. Runs entirely in Docker — no
host Node.js required.

## Quick Start

```sh
docker compose up
```

Open <http://localhost:7007> and sign in as
**guest**.

## What's Included

- **Software Catalog** with sample systems,
  components, APIs, and resources
- **TechDocs** with local mkdocs generation
- **Search** across catalog and docs
- **Scaffolder** with an example Node.js template

### Sample Catalog Entities

| Kind      | Name               | System          |
|-----------|--------------------|-----------------|
| System    | examples           | —               |
| System    | payment-platform   | —               |
| Component | example-website    | examples        |
| Component | payment-api        | payment-platform|
| Component | payment-frontend   | payment-platform|
| Component | inventory-service  | payment-platform|
| API       | example-grpc-api   | examples        |
| API       | payment-rest-api   | payment-platform|
| Resource  | payment-db         | payment-platform|

## Offline Docs

Backstage documentation can be mirrored locally:

```sh
wget --mirror --convert-links --adjust-extension \
  --page-requisites --no-parent \
  -P ./offline-docs \
  https://backstage.io/docs/
```

Then open `offline-docs/backstage.io/docs/index.html`.

## Project Structure

```
├── Dockerfile                  # Multi-stage build
├── docker-compose.yml          # Backstage + PostgreSQL
├── app-config.yaml             # Dev config (SQLite)
├── app-config.production.yaml  # Docker config (Postgres)
├── packages/
│   ├── app/                    # Frontend
│   └── backend/                # Backend
├── plugins/                    # Custom plugins
└── examples/
    ├── entities.yaml           # Catalog data
    ├── org.yaml                # Users & groups
    ├── template/               # Scaffolder template
    └── example-docs/           # TechDocs site
```

## Common Commands

```sh
docker compose up           # Start
docker compose down         # Stop and remove
docker compose build        # Rebuild after code changes
docker compose logs -f      # Follow logs
```

Config changes (`app-config*.yaml`, `examples/`)
are volume-mounted — just restart to pick them up.
Code changes (`packages/`) require a rebuild.

## Adding Catalog Entities

1. Edit or create YAML files in `examples/`
2. Reference them in `app-config.yaml` under
   `catalog.locations`
3. Restart: `docker compose restart backstage`
