import boto3
import uuid
import os
import json

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

def lambda_handler(event, context):
    print("event received:", event)

    # Parse the actual request body
    body = json.loads(event["body"])

    # STORE CLEAN DATA (not full event wrapper)
    item = {
        "event_id": str(uuid.uuid4()),
        "service": body.get("service"),
        "event_type": body.get("event_type"),
        "environment": body.get("environment")
    }

    table.put_item(Item=item)

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Event logged", "event_id": item["event_id"]})
    }
