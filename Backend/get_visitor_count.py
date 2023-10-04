import boto3
"""
Grab the count from the dynamo-db resource
"""
def handler(event):   
    dynamodb_client = boto3.resource('dynamodb')
    table = dynamodb_client.Table(event["table_name"])
    
    update_expression = "SET {} = if_not_exists({}, :start) + :inc".format(event['db_attribute'], event['db_attribute'])
    
    response = table.update_item(
        Key={
            event['db_key']: event['db_key_value']
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