import unittest
from moto import mock_dynamodb
from boto3 import resource
import os
from serverless_data_pipeline import get_visitor_count

TABLE_NAME = "visits"
DB_KEY = "id"
DB_KEY_VALUE = "1"
DB_ATTRIBUTE = "visits"

@mock_dynamodb
class TestGetVisitorCount(unittest.TestCase):

    def setUp(self) -> None:
        self.dynamodb = resource("dynamodb", region_name="us-east-1")
        self.table = self.dynamodb.create_table(
            TableName = TABLE_NAME,
            KeySchema = [{"AttributeName": DB_KEY, "KeyType": "HASH"}],
            AttributeDefinitions = [{"AttributeName": DB_KEY, "AttributeType": "S"}],
            BillingMode = 'PAY_PER_REQUEST'
        )
        self.table.put_item(Item={DB_KEY: DB_KEY_VALUE, DB_ATTRIBUTE:0})

    def tearDown(self) -> None:
        print(5)

    def test_table_created(self) -> None:
        response = self.table.get_item(Key={
            DB_KEY: DB_KEY_VALUE
        })

        assert 'Item' in response
        assert response['Item'][DB_ATTRIBUTE] == 0

    def test_lambda_handler(self) -> None:
        request_body = {
            "table_name": TABLE_NAME,
            "db_key": DB_KEY,
            "db_key_value": DB_KEY_VALUE,
            "db_attribute": DB_ATTRIBUTE
        }
        response = get_visitor_count.handler(request_body)
        assert response["status_code"] == 200
        assert response["visit_count"] == 1