---
description: Defines the implementation rationale, engineering preferences, and technical decision-making standards used throughout the repository.
---

# Technical Design Standards

This document explains the implementation rationale, engineering preferences, and technical decision-making standards used throughout the repository.

This file is intended to help:

- engineers make consistent implementation decisions
- AI agents infer preferred solutions
- contributors understand tradeoffs
- maintain long-term technical coherence

## Engineering Philosophy

### Decision Priorities

When multiple solutions are possible, prioritise:

1. maintainability
2. simplicity
3. explicitness
4. edge compatibility
5. operational efficiency
6. performance
7. abstraction reuse

## Design Preferences

### Prefer

- composition over inheritance
- explicit code over hidden magic
- framework-native primitives
- platform APIs before dependencies
- runtime validation alongside static typing
- colocated feature architecture
- incremental complexity
- progressive enhancement
- focused reusable utilities

### Avoid

- premature abstraction
- heavyweight frameworks for small problems
- dependency sprawl
- clever but opaque implementations
- tightly coupled modules
- hidden runtime behaviour

## Frontend Design Guidance

### Component Design

Preferred characteristics:

- small focused responsibility
- explicit props
- accessibility-first markup
- low client-side JavaScript
- resumability-friendly behaviour

Avoid:

- oversized shared components
- business logic embedded in UI
- unnecessary client effects
- excessive prop drilling without justification

## Backend Design Guidance

### Service Design

Business logic should:

- remain isolated from transport concerns
- support composition
- avoid hidden mutations
- remain easy to test
- remain runtime-agnostic where practical

### Validation Design

All external input should:

- be validated at boundaries
- use shared schemas where possible
- fail explicitly
- avoid implicit coercion unless intentional

## API Design Guidance

### API Characteristics

Preferred APIs are:

- predictable
- strongly typed
- version-aware
- runtime validated
- small and focused

### Response Standards

Responses should:

- remain structurally consistent
- avoid leaking internals
- expose meaningful error messages
- support pagination where needed

## Testing Design Guidance

### Preferred Testing Style

- behaviour-focused
- deterministic
- low-maintenance
- implementation-agnostic where possible

### Test Priorities

Priority order:

1. business-critical logic
2. validation boundaries
3. integration behaviour
4. critical user journeys

## Performance Design Guidance

### Optimisation Philosophy

Rules:

- measure before optimising
- optimise bottlenecks only
- prefer architectural efficiency over micro-optimisation
- minimise client JavaScript
- minimise runtime overhead

### Edge Runtime Considerations

Design assuming:

- cold starts matter
- bundle size matters
- Node APIs may not exist
- latency should remain globally low

## Dependency Evaluation Standards

Before adding a dependency, evaluate:

- edge-runtime compatibility
- maintenance quality
- TypeScript support
- bundle/runtime cost
- whether native APIs solve the problem already

## AI Agent Implementation Guidance

### Feature Implementation Workflow

Recommended order:

1. inspect surrounding patterns
2. reuse existing utilities
3. introduce minimal code changes
4. validate runtime compatibility
5. preserve repository conventions

### Preferred AI Agent Behaviour

AI agents should:

- favour consistency over novelty
- minimise file creation
- minimise abstraction layers
- prefer incremental refactors
- avoid speculative architecture

### Never

- bypass validation systems
- introduce unnecessary dependencies
- add client hydration unnecessarily
- replace lightweight solutions with heavyweight frameworks
- introduce Node-only assumptions into edge runtimes

## Related Documentation

| Document | Purpose |
|---|---|
| `AGENTS.md` | Agent instructions and workflows |
| `TECH_STACK.md` | Approved technologies and tooling |
| `ARCHITECTURE.md` | Structural system architecture |
| `README.md` | Project overview |
| `CONTRIBUTING.md` | Contribution standards |

## Final Principle

Your responsibility is not merely to follow design standards.

Your responsibility is to make consistent, well-reasoned implementation decisions that keep the system coherent and maintainable over time.
