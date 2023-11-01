resource "aws_api_gateway_domain_name" "api" {
  certificate_arn = aws_acm_certificate.api-domain.arn
  domain_name     = "api.jakemittlemanresu.me"
  depends_on = [ aws_acm_certificate_validation.api ]
}

resource "aws_api_gateway_base_path_mapping" "api" {
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.api-stage.stage_name
  domain_name = aws_api_gateway_domain_name.api.domain_name
}