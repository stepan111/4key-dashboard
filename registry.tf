

resource "helm_release" "registry" {
  name              = "registry"
  chart             = "docker-registry"
  repository        = "https://helm.twun.io"
  namespace         = "registry"
  dependency_update = "true"
  create_namespace  = "true"

}
