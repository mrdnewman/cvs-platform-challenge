# Platform Event Logging Service

## Overview

This project is a **self-service event logging API** built on AWS.

It allows GitHub Actions, CLI tools, and applications to send operational events to a centralized system for **tracking, auditing, and observability**.

---

## Architecture

![Architecture](diagrams/architecture.png)

```text
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

---

## How It Works

1. A client sends an HTTP POST request with an event payload
2. API Gateway receives the request
3. Lambda validates and processes the payload
4. Event is stored in DynamoDB
5. Logs are written to CloudWatch
6. Response is returned to the client

---

## Example Payload

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

* Public HTTP endpoint
* Routes requests to Lambda

### Lambda (Python)

* Located in `app/handler.py`
* Handles:

  * input validation
  * error handling
  * structured logging
  * DynamoDB writes

### DynamoDB

* Stores event records
* On-demand billing (`PAY_PER_REQUEST`)
* Primary key: `event_id`

### CloudWatch

* Captures logs and metrics from Lambda

---

## Infrastructure (Terraform)

Terraform provisions all AWS resources.

### Backend

* **S3 bucket** → Terraform remote state
* **DynamoDB table** → state locking

### Application Infrastructure

* DynamoDB (event storage)
* IAM roles and policies
* Lambda function
* API Gateway

---

## Repository Structure

```bash
.
├── app/
│   ├── handler.py          # Lambda function
│   ├── function.zip        # Deployment package
│   └── handler.py.bak      # backup (not used)
├── diagrams/
│   └── architecture.png
├── terraform/
│   ├── bootstrap/          # backend setup (S3 + DynamoDB)
│   ├── main/               # root Terraform configuration
│   └── modules/
│       ├── api_gateway/
│       ├── dynamodb/
│       ├── IAM/
│       └── lambda/
├── cmds/                   # helper commands/scripts
├── CLAUDE.md
└── README.md
```

---

## CI/CD (GitHub Actions + OIDC)

* Uses **OIDC** for secure AWS authentication
* No hardcoded credentials
* Pipeline:

  * authenticates to AWS
  * sends event payload to API

---

## Key Design Decisions

### Lambda over ECS

* Faster to build
* No infrastructure management
* Ideal for event-driven workloads

### DynamoDB

* Scalable and serverless
* Fits event-based storage patterns

### API Gateway

* Simple HTTP interface
* Native Lambda integration

### IAM as Separate Module

* Clean separation of concerns
* Reusable and maintainable

---

## Important Notes

* `terraform/bootstrap/terraform.tfstate` should **not be committed**
* `handler.py.bak` is not used (safe to remove)
* `function.zip` is the Lambda deployment artifact

---

## One-Line Summary

Terraform builds the system, API Gateway exposes it, Lambda processes events, DynamoDB stores them, and CloudWatch provides visibility.

---

## Interview Explanation

I built a self-service platform API that records operational events from pipelines, CLI tools, and applications. API Gateway receives requests, Lambda processes and validates them, DynamoDB stores the events, and CloudWatch provides observability. The infrastructure is provisioned with Terraform and integrated with GitHub Actions using OIDC for secure authentication.

---

