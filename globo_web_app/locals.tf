resource "random_integer" "s3_rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  name_prefix    = "${var.naming_prefix}-dev"
  s3_bucket_name = lower("${local.name_prefix}-${random_integer.s3_rand.result}")

  website_content = {
    website = "/website/index.html"
    logo    = "/website/Globo_logo_Vert.png"
  }

  naming_prefix = "${var.naming_prefix}-${var.environment}"
}