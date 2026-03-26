# Example Website

The `example-website` component is a sample
application used to demonstrate Backstage features
such as the Software Catalog, TechDocs, and the
scaffolder.

## Overview

This website serves as a playground entry point.
It is registered in the catalog under the
`examples` system and owned by the `guests` group.

## Key Features

- **Software Catalog integration** -- registered
  as a Component of type `website`.
- **TechDocs** -- documentation built with MkDocs
  and served through Backstage.
- **API consumption** -- demonstrates how
  components can declare API relationships via
  `providesApis` and `consumesApis`.

## Related Components

| Component           | Type    | System           |
|---------------------|---------|------------------|
| example-website     | website | examples         |
| payment-api         | service | payment-platform |
| payment-frontend    | website | payment-platform |
| inventory-service   | service | payment-platform |

## Links

- [Getting Started](getting-started.md)
- [Architecture](architecture.md)
