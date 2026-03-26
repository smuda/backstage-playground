# Architecture

This page describes the high-level architecture
of the sample entities in this playground.

## System Diagram

```text
┌─────────────────────────────────────────────┐
│              payment-platform               │
│                                             │
│  ┌──────────────┐    ┌──────────────────┐   │
│  │  payment-     │    │   payment-api    │   │
│  │  frontend     │───>│   (service)      │   │
│  │  (website)    │    │                  │   │
│  └──────────────┘    └────────┬─────────┘   │
│                               │             │
│                               v             │
│                        ┌────────────┐       │
│                        │ payment-db │       │
│                        │ (postgres) │       │
│                        └────────────┘       │
│                                             │
│  ┌──────────────────┐                       │
│  │ inventory-service │                      │
│  │ (service)         │                      │
│  └──────────────────┘                       │
└─────────────────────────────────────────────┘
```

## Request Flow

1. A customer opens the **payment-frontend**.
2. The frontend calls the **payment-rest-api**
   exposed by `payment-api`.
3. `payment-api` validates the request, writes a
   record to **payment-db**, and returns the
   result.
4. The **inventory-service** can be called
   separately to check stock before a payment
   is created.

## API Contracts

- **payment-rest-api** -- OpenAPI 3.0 spec with
  two endpoints:
    - `POST /payments` -- create a new payment.
    - `GET /payments/{id}` -- retrieve a payment.
- **example-grpc-api** -- protobuf definition
  with a single `Example` RPC.

## Data Stores

| Resource   | Engine     | Owner         |
|------------|------------|---------------|
| payment-db | PostgreSQL | platform-team |

## Ownership

| Team          | Owns                                  |
|---------------|---------------------------------------|
| platform-team | payment-api, inventory-service,       |
|               | payment-db, payment-rest-api          |
| frontend-team | payment-frontend                      |
| guests        | example-website, example-grpc-api     |
