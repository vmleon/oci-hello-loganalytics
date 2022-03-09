resource "helm_release" "hello-api" {
  name       = "hello-api"
  chart      = "../helm-charts/hello-api"
}