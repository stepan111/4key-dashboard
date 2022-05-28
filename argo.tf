

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  #version           = "0.1.0"
  namespace         = "argo"
  dependency_update = "true"
  create_namespace  = "true"

  values = [
    file("${path.root}/argocd-values.yaml",
    )
  ]
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubernetes_config_map" "example" {
  metadata {
    name      = "argocd-rbac-cm"
    namespace = "argo"
  }

  data = {
    "policy.default" = "role:admin"

  }
  depends_on = [
    helm_release.argocd
  ]

}

resource "helm_release" "workflow" {
  name       = "argowf"
  chart      = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  #version           = "0.1.0"
  namespace         = "argo"
  dependency_update = "true"
  create_namespace  = "true"

  values = [
    file("${path.root}/argowf-values.yaml",
    )
  ]
  depends_on = [
    helm_release.prometheus
  ]
}

resource "helm_release" "events" {
  name       = "argoevents"
  chart      = "argo-events"
  repository = "https://argoproj.github.io/argo-helm"
  #version           = "0.1.0"
  namespace         = "argo"
  dependency_update = "true"
  create_namespace  = "true"

}

data "kubectl_file_documents" "docs" {
  content = file("${path.module}/argo-app.yaml")
}

resource "kubectl_manifest" "test" {
  for_each  = data.kubectl_file_documents.docs.manifests
  yaml_body = each.value
  depends_on = [
    helm_release.argocd
  ]
}


