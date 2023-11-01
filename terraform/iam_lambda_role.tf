resource "aws_iam_role" "visitor-count-role" {
  name               = "VisitorCountRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "visitor-count-policy" {
  name = "visitor-count-policy"
  role = aws_iam_role.visitor-count-role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:UpdateItem",
            ],
            "Resource": [
                "${aws_dynamodb_table.cloud-resume-challenge.arn}"
            ]
        }
    ]
})
}
