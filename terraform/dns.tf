resource "porkbun_dns_record" "dns_validation" {
    for_each = {
        for dvo in aws_acm_certificate.cloud-resume-cert.domain_validation_options : dvo.domain_name => {
            domain  = var.base_domain
            name    = dvo.resource_record_name
            content  = dvo.resource_record_value
            type    = dvo.resource_record_type
        }
    }
    domain = var.base_domain
    name = trim(each.value.name, ".jakemittlemanresu.me")
    type = each.value.type
    content = trim(each.value.content, ".")
    depends_on = [ aws_acm_certificate.cloud-resume-cert ]
}

resource "porkbun_dns_record" "redirect" {
    domain = var.base_domain
    name = "s3"
    type = "CNAME"
    content = aws_cloudfront_distribution.s3_distribution.domain_name
    depends_on = [ aws_cloudfront_distribution.s3_distribution ]
}

resource "porkbun_dns_record" "api-dns_validation" {
    for_each = {
        for dvo in aws_acm_certificate.api-domain.domain_validation_options : dvo.domain_name => {
            domain  = var.base_domain
            name    = dvo.resource_record_name
            content  = dvo.resource_record_value
            type    = dvo.resource_record_type
        }
    }
    domain = var.base_domain
    name = trimsuffix(each.value.name, ".jakemittlemanresu.me.")
    type = each.value.type
    content = trimsuffix(each.value.content, ".")
    depends_on = [ aws_acm_certificate.api-domain ]
}

resource "porkbun_dns_record" "api" {
    domain = var.base_domain
    name = "api"
    type = "CNAME"
    content = aws_api_gateway_domain_name.api.cloudfront_domain_name
    depends_on = [ aws_api_gateway_domain_name.api ]
}