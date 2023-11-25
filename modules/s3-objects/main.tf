resource "aws_s3_object" "object" {
  bucket = var.s3_web_name
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"


  etag = filemd5("index.html")
}

resource "aws_s3_object" "visitor_counter_object" {
  bucket = var.s3_web_name
  key    = "script/visitorCounter.js"
  source = "script/visitorCounter.js"
  content_type = "text/javascript"
  


  etag = filemd5("script/visitorCounter.js")
}

resource "aws_s3_object" "style_object" {
  bucket = var.s3_web_name
  key    = "style/style.css"
  source = "style/style.css"
  content_type = "text/css"


  etag = filemd5("style/style.css")
}