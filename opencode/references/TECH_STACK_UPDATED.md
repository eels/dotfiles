---
description: Defines the approved technologies, tooling choices, runtime constraints, and implementation conventions for this repository.
---

# Technology Stack & Tooling

This document defines the approved technologies, tooling choices, runtime constraints, and implementation conventions for this repository.

It is intentionally concise and optimised for:

- rapid AI agent ingestion
- implementation consistency
- dependency governance
- edge-runtime compatibility
- predictable architectural decisions

If this document conflicts with:

1. `AGENTS.md` → follow `AGENTS.md`
2. direct task requirements → follow the task requirements

---

## Core Technology Decisions

| Concern | Approved Technology | Notes |
|---|---|---|
| Frontend Framework | Qwik + Qwik City | Default frontend architecture |
| Language | TypeScript | Strict mode required |
| Styling | Tailwind CSS | Utility-first styling |
| UI Composition | `@micheldever/qwik-compose` | Preferred utility for composing Qwik + Tailwind CSS component variants |
| Validation | Zod | Shared schemas preferred |
| Backend Runtime | Cloudflare Workers | Default runtime target |
| Backend Framework | Hono | Preferred API framework |
| ORM | Drizzle ORM | Typed schema-first approach |
| Database | PostgreSQL / SQLite | Depends on scale |
| Edge Database | Cloudflare D1 | Default edge-hosted relational DB |
| Object Storage | Cloudflare R2 | Default blob/file storage |
| Cache | Cloudflare KV | Lightweight edge caching |
| Background Jobs | Cloudflare Queues | Async processing |
| Testing | Vitest + Playwright | Unit + E2E |
| CI/CD | GitHub Actions | Preferred automation |
| IaC | Terraform | Optional for larger systems |
| Monorepo Workflow | Turborepo | Preferred monorepo tooling |

---

## Frontend Standards

### Preferred

- server-first rendering
- resumability-friendly patterns
- small focused components
- progressive enhancement
- accessibility-first implementation
- explicit prop typing
- colocated routes/loaders/actions
- framework-native state primitives
- shared lightweight UI primitives
- use `@micheldever/qwik-compose` for Tailwind-powered component composition and variants
- keep Tailwind class composition declarative and reusable
- prefer composable variant-driven styling patterns over inline conditional class logic

### Avoid

- large hydration boundaries
- monolithic component libraries
- excessive client-side effects
- over-abstracted component systems
- global state without justification
- inline business logic inside UI components
- ad-hoc Tailwind class concatenation across components
- duplicated variant logic
- deeply nested conditional class builders

---

## Backend Standards

### Preferred

- thin route handlers
- isolated business logic services
- explicit request/response schemas
- stateless request handling
- shared validation schemas
- functional composition
- edge-compatible libraries only

### Avoid

- Express-style middleware sprawl
- Node-only dependencies
- hidden side effects
- mutable shared state
- fat controllers/routes
- circular dependencies

---

## Database Standards

### Preferred

- explicit schema definitions
- SQL-first design
- typed migrations
- indexed lookup fields
- relational modelling
- transaction boundaries for multi-step writes

### Avoid

- ORM magic abstractions
- unbounded queries
- hidden DB side effects
- oversized JSON blobs
- business logic in triggers

---

## Testing Stack

| Test Type | Tooling |
|---|---|
| Unit Tests | Vitest |
| Component Tests | Testing Library |
| E2E Tests | Playwright |

### Testing Principles

Preferred:

- behaviour-focused tests
- deterministic test execution
- minimal mocking
- critical-path E2E coverage

Avoid:

- brittle implementation-coupled tests
- snapshot-heavy suites
- excessive E2E coverage
- over-mocking internals

---

## Repository Standards

### Package Management

- use yarn classic
- commit lockfiles
- prefer workspaces over relative imports

### Quality Gates

Required before merge:

- lint passes
- typecheck passes
- tests pass
- build succeeds

### Tooling

| Concern | Tool |
|---|---|
| Linting | ESLint |
| Type Checking | TypeScript |
| Git Hooks | Husky |

---

## Dependency Philosophy

### Preferred

- small focused libraries
- web standards first
- edge-compatible dependencies
- runtime-light tooling
- strong TypeScript support
- composable styling utilities aligned with Qwik resumability patterns

### Avoid

- large framework ecosystems
- poorly maintained dependencies
- unnecessary utility wrappers
- Node-specific packages in edge runtimes

---

## AI Agent Guidance

### When Implementing

- reuse existing patterns first
- prefer Qwik-native approaches
- minimise new abstractions
- keep changes small and focused
- maintain edge compatibility
- prefer editing existing files
- when building reusable UI components with Qwik + Tailwind CSS, use `@micheldever/qwik-compose`
- prefer shared composable styling primitives over duplicated Tailwind utilities
- centralise component variant definitions where possible

---

## Qwik + Tailwind Composition Standards

When using Qwik together with Tailwind CSS:

- use `@micheldever/qwik-compose` for reusable component styling
- define variants through composition utilities rather than manual string concatenation
- prefer predictable variant APIs for shared UI primitives
- keep styling colocated in a sibling `styled.ts` file to the component
- avoid runtime-heavy styling abstractions

### Avoid

- large CSS-in-JS systems
- runtime style generation
- inconsistent Tailwind variant implementations
- duplicated utility class patterns

### Never

- introduce Node-only dependencies without justification
- bypass validation or typing
- duplicate existing utilities
- introduce unnecessary hydration

---

## Final Principle

Your responsibility is not merely to know the tech stack.

Your responsibility is to use it consistently, justify deviations, and ensure every dependency and tooling choice serves the long-term health of the project.
