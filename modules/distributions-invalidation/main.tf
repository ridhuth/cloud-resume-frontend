# Invalidate the CF cache when S3 website home page is updated
resource "null_resource" "invalidate_cf_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.distribution_id} --paths '/*'"
  }

  triggers = {
    etag_changed = var.index_html_etag
  }

}

# Invalidate the CF cache when S3 website javascript is updated
resource "null_resource" "invalidate_cf_js_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.distribution_id} --paths '/script/*'"
  }
  triggers = {
    etag_changed = var.counter_js_etag
  }
}

# Invalidate the CF cache when S3 website style is updated
resource "null_resource" "invalidate_cf_css_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${var.distribution_id} --paths '/style/*'"
  }
  triggers = {
    etag_changed = var.style_css_etag
  }
}