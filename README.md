# Platform Event Logging Service

## Overview

This project is a **self-service developer event logging API** built on AWS.

It allows GitHub Actions, CLI tools, and applications to send operational events to a centralized system for **tracking, auditing, and observability**.

In simple terms:

> A client sends an event → the API processes it → the event is stored → logs are captured.

---

## Problem This Solves

AWS provides infrastructure-level logging (CloudWatch, CloudTrail), but it does **not track custom platform events** such as:

* deployment started / succeeded / failed
* job completed
* service registered

This service fills that gap by providing a **developer-facing event layer**.

---

## Architecture

```
GitHub Actions / CLI / App
        ↓
   API Gateway
        ↓
     Lambda (Python)
        ↓
    DynamoDB
        ↓
   CloudWatch
```

### Flow

1. Client sends HTTP POST request with event payload
2. API Gateway receives and routes request
3. Lambda validates and processes the request
4. Event is stored in DynamoDB
5. Logs are written to CloudWatch
6. Response is returned to client

---

## Example Event Payload

```json
{
  "service": "github-actions",
  "event_type": "push_event",
  "environment": "dev"
}
```

---

## Core Components

### API Gateway

* Public HTTP entrypoint
* Routes requests to Lambda

### Lambda (Python)

* Validates input
* Handles errors
* Writes structured logs
* Stores events in DynamoDB

### DynamoDB

* Stores event records
* On-demand billing (`PAY_PER_REQUEST`)
* Primary key: `event_id`

### CloudWatch

* Logs Lambda execution
* Provides observability and debugging

---

## Terraform Infrastructure

Terraform is used to provision all infrastructure:

* S3 bucket (remote state)
* DynamoDB table (state locking)
* DynamoDB table (event storage)
* IAM roles and policies
* Lambda function
* API Gateway

### Backend Setup

* **S3** → stores Terraform state
* **DynamoDB** → handles state locking

> Note: These are not part of the application runtime.

---

## Why Two DynamoDB Tables?

| Table                | Purpose                            |
| -------------------- | ---------------------------------- |
| Terraform Lock Table | Prevents concurrent Terraform runs |
| Events Table         | Stores application event data      |

---

## CI/CD and OIDC

GitHub Actions uses **OIDC (OpenID Connect)** for secure AWS authentication:

* No static AWS credentials
* Short-lived tokens
* IAM role assumption

The pipeline:

* Authenticates to AWS
* Sends event payloads to the API

---

## Repository Structure

```bash
terraform/
├── bootstrap/        # S3 + DynamoDB backend
├── modules/          # reusable Terraform modules
│   └── dynamodb/
├── main/             # root composition layer
app/                  # Lambda source code
.github/workflows/    # CI/CD pipeline
```

---

## Design Decisions

### Why Lambda

* Serverless
* Fast to build
* Minimal operational overhead

### Why DynamoDB

* Scalable
* Fully managed
* Ideal for event-style data

### Why API Gateway

* Simple HTTP interface
* Native Lambda integration
* Clean entrypoint for external systems

---

## Self-Service Model

This API allows systems to record events **without manual intervention**.

Instead of relying on infrastructure teams, developers and pipelines can:

> Send events directly → API handles the rest

---

## What Was Implemented

* Terraform backend (S3 + DynamoDB locking)
* DynamoDB event storage
* Modular Terraform structure
* GitHub Actions OIDC authentication
* CI pipeline sending event payloads
* Full serverless event ingestion flow

---

## Key Distinction

| Concept   | Purpose                     |
| --------- | --------------------------- |
| Terraform | Builds infrastructure       |
| API       | Processes and stores events |

---

## One-Line Summary

Terraform builds the system, API Gateway exposes it, Lambda runs the logic, DynamoDB stores the events, and CloudWatch provides visibility.

---

## Interview Explanation (Short)

I built a self-service platform API that records operational events from pipelines, CLI tools, and applications. API Gateway receives requests, Lambda processes and validates them, DynamoDB stores the events, and CloudWatch provides observability. The infrastructure is provisioned using Terraform with secure CI/CD via GitHub Actions OIDC.

---

