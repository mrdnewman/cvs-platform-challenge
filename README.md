
</div>

---

## What It Does

- Accepts event data via HTTP POST
- Validates and processes incoming payloads
- Stores structured event data in DynamoDB
- Emits logs and metrics via CloudWatch

---

## Example Event

```json
{
  "service": "github-actions",
  "event_type": "push_event",
  "environment": "dev"
}

---

Infrastructure (Terraform)

This project uses Terraform to provision:

API Gateway
Lambda Function
DynamoDB Table
IAM Roles & Policies
S3 Backend for state
DynamoDB for state locking
Backend Setup
S3 bucket for Terraform state
DynamoDB table for state locking
CI/CD Integration

GitHub Actions pipeline:

Uses OIDC to securely authenticate with AWS
Sends event payloads to the API
Demonstrates real-world integration
Security
OIDC-based authentication for CI/CD
Least-privilege IAM roles
Encrypted Terraform state (S3)
AI Usage

AI was used as a development assistant for:

Terraform scaffolding
Architecture design refinement
Debugging IAM/OIDC configuration
Improving code clarity and structure

All AI-assisted changes are documented via commits and pull requests.

Key Design Decisions
Lambda over ECS → faster, simpler, serverless
DynamoDB → scalable, low-maintenance storage
API Gateway → clean public interface
Terraform modules → reusable and maintainable infra
Future Improvements
Add API authentication (IAM or JWT)
Add query endpoint for event retrieval
Enhance observability (metrics + alerts)
Expand event schema validation
Summary

This project demonstrates the ability to:

Design a platform-level service
Build scalable cloud infrastructure with Terraform
Implement CI/CD integration with secure AWS access
Deliver clean, maintainable, production-style code
