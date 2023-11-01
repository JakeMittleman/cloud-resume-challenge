import boto3
import json
"""
Grab the count from the dynamo-db resource
"""
def handler(event, context):
    dynamodb_client = boto3.resource('dynamodb', region_name="us-east-1")
    table = dynamodb_client.Table("s3.jakemittlemanresu.me")
    
    update_expression = "SET {} = if_not_exists({}, :start) + :inc".format("visits", "visits")
    
    response = table.update_item(
        Key={
            "id": "1"
        },
        UpdateExpression=update_expression,
        ExpressionAttributeValues={
            ':inc': 1,
            ':start': 0,
        },
        ReturnValues="UPDATED_NEW"
    )
    
    return {
        "statusCode": 200,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        "body": json.dumps({"visit_count": str(response["Attributes"]["visits"])})
    }