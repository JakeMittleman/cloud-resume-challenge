resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowApiLambdaAccess"
  action        = "lambda:InvokeFunction"
  function_name = "getVisitorCount"
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*"
}