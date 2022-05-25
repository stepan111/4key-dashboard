terraform {

  # backend "s3" {
  #   skip_credentials_validation = true
  #   skip_metadata_api_check     = true
  #   endpoint                    = "https://ams3.digitaloceanspaces.com"
  #   region                      = "us-east-1" // needed
  #   bucket                      = "toptal-interview-tf-state" // name of your space
  #   key                         = "terraform/infra.tfstate"
  # }


  required_providers {
    #     kind = {
    #       source = "marcwickenden/kind"
    #       #   version = "~> 0.0.1"
    #     }
    kubectl = {
      source  = "registry.terraform.io/gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "registry.terraform.io/fluxcd/flux"
      version = ">= 0.0.13"
    }
  }
}

