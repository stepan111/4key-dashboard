
provider "helm" {
  kubernetes {
    config_context = "kind-cluster"
    config_path    = "~/.kube/config"
  }

}


resource "helm_release" "prometheus" {
  name              = "prometheus"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "kube-prometheus-stack"
  wait              = true
  atomic            = true
  namespace         = "monitoring"
  create_namespace  = "true"
  dependency_update = true
  #version           = local.helmVersion
  values = [
    file("${path.module}/kube-prometheus-stack-values.yaml")
  ]


}
