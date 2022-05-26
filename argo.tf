

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
