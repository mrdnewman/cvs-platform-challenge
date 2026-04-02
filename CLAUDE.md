# AI Usage Disclosure (CLAUDE.md)

## Overview

This project was developed with the assistance of AI to accelerate development, iterate quickly, and validate implementation patterns.

AI was used extensively as a **productivity tool**, but all architectural decisions, system design choices, and final validations were performed manually.

---

## Tools Used

* ChatGPT (GPT-5.3)

---

## How AI Was Used

### Architecture & Design

AI was used to explore and validate architectural patterns for a serverless event logging system.

This included:

* Evaluating API Gateway → Lambda → DynamoDB flow
* Discussing service tradeoffs (e.g., Lambda vs ECS)

The final architecture and system design were determined independently and validated through implementation.

---

### Terraform & Infrastructure

AI assisted with:

* Scaffolding Terraform modules
* Backend configuration (S3 remote state + DynamoDB locking)
* Debugging infrastructure and integration issues

However, the overall Terraform structure and modular design were based on prior experience and intentionally implemented.

#### Module Design Decisions (Manual)

* Infrastructure was broken into modules (`IAM`, `lambda`, `api_gateway`, `dynamodb`) to enforce:

  * separation of concerns
  * reusability
  * independent evolution of components

* Root-level variables with defaults were used instead of `.tfvars` because:

  * this is a single-environment system
  * configuration does not change frequently
  * simplicity was prioritized over flexibility

* `.tfvars` would be introduced if:

  * multiple environments were required (dev/stage/prod)
  * configuration values needed to vary dynamically

---

### AWS Integration

AI was used to reason through integration patterns, including:

* API Gateway → Lambda invocation
* DynamoDB interaction patterns
* IAM role configuration

Core integration decisions were made independently, including:

* using API Gateway as the ingestion layer
* using Lambda for processing
* using DynamoDB as the event store

All integrations (IAM, OIDC, API Gateway, Lambda, DynamoDB) were validated end-to-end.

---

### Lambda Development (Python)

AI assisted with:

* Initial handler scaffolding
* Validation and logging patterns

The implementation was reviewed, tested, and adjusted to ensure correct behavior and proper integration.

---

### CI/CD (GitHub Actions + OIDC)

AI was used to:

* Understand OIDC authentication flow
* Debug repository identity issues
* Refine workflow structure

The final pipeline was validated through successful AWS authentication and event submission.

---

## What Was Done Manually

* Final system architecture and service selection
* Terraform module design and structure
* Integration of API Gateway, Lambda, and DynamoDB
* IAM role validation and OIDC configuration
* Debugging infrastructure and runtime issues
* Terraform execution and verification
* End-to-end testing of event ingestion flow

---

## Validation Approach

All AI-assisted outputs were:

* Reviewed before implementation
* Tested in a live AWS environment
* Verified through Terraform plan/apply cycles
* Confirmed via successful API execution and DynamoDB writes

---

## Summary

AI was used extensively to accelerate development, particularly for scaffolding, iteration, and debugging.

However, all architectural decisions, module design choices, integrations, and validations were performed manually.

AI was treated as a **productivity tool, not a source of truth**, and the final system reflects a fully implemented and understood architecture.

