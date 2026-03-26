# Getting Started

This guide explains how to run the Backstage
playground and explore the sample catalog data.

## Prerequisites

- Node.js 18+ and Yarn installed
- A local clone of this repository

## Running the App

```bash
yarn install
yarn dev
```

Backstage will start on `http://localhost:3000`.

## Exploring the Catalog

Once the app is running you can explore these
sample entities:

1. **Systems** -- `examples` and
   `payment-platform` group related components.
2. **Components** -- `example-website`,
   `payment-api`, `payment-frontend`, and
   `inventory-service`.
3. **APIs** -- `example-grpc-api` (gRPC) and
   `payment-rest-api` (OpenAPI).
4. **Resources** -- `payment-db` (PostgreSQL
   database).

## Creating New Components

Use the scaffolder template at
`examples/template/template.yaml` to create a
new Node.js service from a template. Navigate to
**Create** in the sidebar and choose the
"Example Node.js Template".

## Teams and Ownership

The sample org data defines three groups:

- **guests** -- default group for the guest user.
- **platform-team** -- owns backend services and
  infrastructure.
- **frontend-team** -- owns frontend applications.

Each component declares an `owner` so you can
filter the catalog by team.
