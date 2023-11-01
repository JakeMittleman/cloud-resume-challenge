resource "aws_s3_bucket" "cloud-resume-challenge" {
  bucket = "s3.jakemittlemanresu.me"
  force_destroy = true

  tags = {
    Name = "s3.jakemittlemanresu.me"
  }
}

resource "aws_s3_bucket_website_configuration" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_public_access_block" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.cloud-resume-challenge.bucket
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.cloud-resume-challenge.arn}/*"
        }
    ]
  }
  POLICY

  depends_on = [ aws_s3_bucket.cloud-resume-challenge, aws_s3_bucket_website_configuration.cloud-resume-challenge, aws_s3_bucket_cors_configuration.cloud-resume-challenge, aws_s3_bucket_public_access_block.cloud-resume-challenge ]
}
