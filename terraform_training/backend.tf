terraform {
  backend "gcs" {
    bucket  = "terrafom_monitoring"
    prefix  = "terraform"
    credentials = "service-account.json"
    encrypt = true
  }
} 