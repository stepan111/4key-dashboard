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
    kubectl = {
      source  = "registry.terraform.io/gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }
}


provider "helm" {
  kubernetes {
    config_context = "kind-cluster"
    config_path    = "~/.kube/config"
  }

}


provider "kubernetes" {
  config_context = "kind-cluster"
  config_path    = "~/.kube/config"
}
