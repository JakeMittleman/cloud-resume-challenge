resource "aws_dynamodb_table" "cloud-resume-challenge" {
  name           = "s3.jakemittlemanresu.me"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "cloud-resume-challenge" {
  table_name = aws_dynamodb_table.cloud-resume-challenge.name
  hash_key   = aws_dynamodb_table.cloud-resume-challenge.hash_key

  item = <<ITEM
{
"id": {"S": "1"},
"visit_count": {"N": "1"}
}
ITEM
}
