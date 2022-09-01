resource "aws_s3_bucket" "summa" {
    bucket = "terras3bucket34"
}

resource "aws_s3_bucket_public_access_block" "summa" {
  bucket = aws_s3_bucket.summa.id
}

resource "aws_s3_object" "summa" {
  #depends_on = [
   # aws_s3_bucket.summa
  #]
  bucket = aws_s3_bucket.summa.bucket
  key    = "summa.html"
  source = "./summa.html"
  acl = "public-read"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  #etag = filemd5("path/to/file")
}

  resource "aws_s3_bucket_website_configuration" "summa" {
  bucket = aws_s3_bucket.summa.id

  index_document {
    suffix = "summa.html"
  }

}
resource "aws_s3_bucket_policy" "terraform" {
  bucket = aws_s3_bucket.summa.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.summa.arn}/*"
        }
    ]

  })
}

output "website_endpoint" {
  value = aws_s3_bucket.summa.website_endpoint
}