output "website_endpoint" {
  description = "Öffentliche Website-URL"
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}