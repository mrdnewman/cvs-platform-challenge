
import boto3
import uuid
import os

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

def lambda_handler(event, context):
    print("event received:", event)  # CloudWatch

    table.put_item(
        Item={
            "event_id": str(uuid.uuid4()),
            "data": str(event)
        }
    )

    return {
        "statusCode": 200,
        "body": "Event logged"
    }