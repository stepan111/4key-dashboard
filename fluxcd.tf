provider "kubectl" {
  load_config_file = true
  config_context   = "kind-cluster"
  config_path      = "~/.kube/config"
}

provider "flux" {}

data "flux_install" "main" {
  target_path = "/"
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

locals {
  install = [for v in data.kubectl_file_documents.install.documents : {
    data : yamldecode(v)
    content : v
    }
  ]

}
resource "kubectl_manifest" "install" {
  for_each  = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  yaml_body = each.value
}

data "kubectl_file_documents" "crds" {
  content = file("${path.module}/fluxcrds.yaml")
}

resource "kubectl_manifest" "crds" {
  count     = 2
  yaml_body = element(data.kubectl_file_documents.crds.documents, count.index)
  depends_on = [
    kubectl_manifest.install
  ]
}
