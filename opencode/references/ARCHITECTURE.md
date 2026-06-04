---
description: Defines the architectural structure, layering strategy, and system-level conventions for this repository.
---

# Architecture & System Design

This document defines the architectural structure, layering strategy, and system-level conventions for this repository.

The goal is to maintain:

- consistency across features
- low operational complexity
- edge-native compatibility
- predictable code organisation
- AI-agent-friendly implementation patterns

If this document conflicts with:

1. `AGENTS.md` → follow `AGENTS.md`
2. direct task requirements → follow the task requirements

---

## Architectural Principles

### Core Principles

- prefer simplicity over abstraction
- prefer explicitness over magic
- prefer composition over inheritance
- optimise for maintainability
- minimise infrastructure complexity
- design for edge-first deployment
- minimise operational overhead
- favour consistency over novelty

---

## High-Level System Architecture

### Frontend Architecture

Preferred Structure:

- feature-oriented modules
- colocated routes/loaders/actions
- small focused UI components
- server-first rendering patterns
- progressively enhanced forms
- shared lightweight primitives

State Strategy:

Preferred order:

1. local component state
2. Qwik signals/context
3. shared state only when justified

Avoid global state stores unless complexity requires them.

---

### Backend Architecture

Request Lifecycle:

Preferred flow:

Request → Validation → Route Handler → Service Layer → Database/External APIs → Response

Route Handlers:

Route handlers should:

- remain thin
- handle orchestration only
- avoid business logic
- validate external input
- return typed responses

Service Layer:

Business logic should:

- live in isolated services/modules
- remain framework-light
- avoid side effects where possible
- support composition
- remain independently testable

---

## API Architecture

### Preferred

- explicit request/response contracts
- runtime validation for all external input
- small focused endpoints
- predictable naming conventions
- pagination for list endpoints
- shared API types when practical

### Avoid

- generic catch-all endpoints
- inconsistent response shapes
- leaking internal implementation details
- breaking API changes without migration plans

---

## Database Architecture

### Preferred Data Design

- relational-first modelling
- explicit schema ownership
- indexed lookup fields
- typed migrations
- transactional multi-step writes
- SQL-first thinking

### Avoid

- document-style relational storage
- excessive JSON columns
- implicit ORM behaviour
- business logic in database triggers

---

## Infrastructure Architecture

### Platform Strategy

Primary infrastructure assumptions:

- Cloudflare-first deployment
- edge-native execution
- stateless services
- managed infrastructure services
- free-tier-conscious architecture

### Hosting Philosophy

Preferred:

- fast cold starts
- globally distributed execution
- low-maintenance managed services
- low operational overhead

Avoid:

- Kubernetes without scale justification
- always-on servers
- multi-cloud complexity
- stateful runtimes

---

## Security Architecture

### Required

- validate all external input
- parameterised queries only
- boundary-based auth enforcement
- escaped untrusted output
- secrets stored in environment bindings

### Never

- commit secrets
- trust client validation
- expose internal stack traces
- log sensitive user data

---

## Performance Architecture

### Preferred

- minimal client JavaScript
- edge-optimised latency
- streamed responses where practical
- caching for expensive operations
- paginated large datasets
- measure before optimisation

### Avoid

- unnecessary abstractions
- large hydration payloads
- N+1 database queries
- premature optimisation

---

## Recommended Repository Structure

```text
applications/
  api/
    src/
      connections/
      datasources/
      lib/
      middleware/
      routes/
      types/
  web/
    src/
      lib/
      loaders/
      queries/
      routes/
      styles/
      types/
      ui/
        tokens/
        components/
        features/
        hooks/
        utilities/

common/
  types/
    src/
  schemas/
    src/
  utilities/
    src/

configurations/
  stylelint/
    lib/
  tailwindcss/
    lib/
  typescript/
    lib/
```

---

## AI Agent Architectural Guidance

### Before Introducing New Patterns

AI agents should:

1. search for existing implementations
2. reuse surrounding conventions
3. prefer lightweight composition
4. preserve architectural consistency
5. minimise new abstractions

### Architectural Anti-Patterns

Never introduce:

- framework-heavy abstractions
- hidden side-effect systems
- duplicated service layers
- tightly coupled feature modules
- Node-specific runtime assumptions

---

## Final Principle

Your responsibility is not merely to define architecture.

Your responsibility is to ensure every implementation stays architecturally consistent, operationally sound, and maintainable over time.
