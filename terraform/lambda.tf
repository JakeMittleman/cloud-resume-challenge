resource "aws_lambda_function" "update_visit_count" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "getVisitorCount.zip"
  function_name = "getVisitorCount"
  role          = aws_iam_role.visitor-count-role.arn
  handler       = "getVisitorCount.handler" 

  source_code_hash = filebase64sha256("getVisitorCount.zip")

  runtime = "python3.9"
}