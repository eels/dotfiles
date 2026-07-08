---
description: Reusable templates for design documentation - DESIGN.md, PRODUCT.md, and structured UI/UX review format.
---

# Design Documentation Templates

This document provides canonical structure templates for design documentation and review. The `@design` agent loads these on demand when producing or evaluating product design systems.

## DESIGN.md Structure

Use this template when documenting a product design system. Each section represents a required area of consideration. Fill in sections relevant to the project's maturity.

```markdown
# Product Design System

## Design Principles
1. [Principle]
2. [Principle]
3. [Principle]

## Product Personality
- Tone
- Emotional characteristics
- Visual descriptors
- Interaction philosophy

## Color System
### Primary Palette
### Secondary Palette
### Semantic Colors
### Neutral Palette
### Accessibility Rules

## Typography
### Font Families
### Scale
### Weight Usage
### Line Height Rules
### Responsive Typography

## Spacing System
### Base Grid
### Component Padding
### Section Rhythm
### Layout Constraints

## Component Philosophy
### Buttons
### Inputs
### Navigation
### Cards
### Tables
### Modals
### Feedback States

## Interaction Design
### Hover Behaviour
### Focus States
### Motion Principles
### Loading States
### Error Handling
### Empty States

## Accessibility Standards
### WCAG Targets
### Keyboard Navigation
### Contrast Rules
### Motion Reduction
### Touch Targets

## Responsive Strategy
### Mobile
### Tablet
### Desktop
### Large Screens

## Design QA Checklist
- Visual consistency
- Spacing accuracy
- Typography validation
- Accessibility compliance
- Responsive verification
```

## PRODUCT.md Structure

Use this template when documenting the product experience overview. It captures the strategic context behind design decisions.

```markdown
# Product Experience Overview

## Product Vision
## User Problems
## User Personas
## Product Tone
## UX Goals
## Core Flows
## Success Criteria
## Friction Risks
## Competitive Inspiration
## Interaction Principles
## Accessibility Expectations
## Design Constraints
## Future UX Opportunities
```

## Design Review Template

Use this template when conducting a structured UI/UX review of implemented interfaces.

```markdown
# UI/UX Review

## Overall Assessment
[High-level product experience evaluation]

## Strengths
- [Positive observation]
- [Positive observation]

## UX Issues
| Issue | Impact | Recommendation |
|-------|--------|----------------|
| [Problem description] | High/Medium/Low | [Suggested improvement] |

## Visual Consistency Issues
- [Spacing inconsistency]
- [Typography mismatch]
- [Hierarchy issue]

## Accessibility Concerns
- [Contrast issue]
- [Focus issue]
- [Interaction issue]

## Interaction Improvements
- [Microinteraction recommendation]
- [Feedback recommendation]

## Priority Recommendations
### Immediate
### Short-term
### Future Improvements
```

## Usage

When generating new DESIGN.md or PRODUCT.md documentation, load the appropriate template above as a starting structure. When conducting a design review, use the review template to ensure consistent coverage of UX, visual, accessibility, and interaction concerns.
