output "bps_pdf_services_iva_repository_url" {
  description = "The URL of the repository bps-pdf-services-iva"
  value       = module.ecr[*].repo1.repository_url

}

output "bpsapps_lambda_source_iva_repository_url" {
  description = "The URL of the repository bpsapps-lambda-source-iva"
  value       = module.ecr[*].repo2.repository_url

}