# Helm commands

`helm repo add bitnami https://charts.bitnami.com/bitnami`

`helm repo list`

`helm repo update`

`helm search repo drupal`

`helm search  repo drupal --versions`

`helm install mysite bitnami/drupal --set drupalUsername=admin`

`helm install mysite bitnami/drupal -n namespace --values values.yaml --dry-run`

`helm list`

`helm upgrade mysite bitnami/drupal --version 6.2.22`

`helm list --all-namespaces`

`helm uninstall mysite`

`helm template mysite bitnami/drupal`

`helm get notes mysite`

`helm get values wordpress`

`helm get values wordpress --revision 2` and `--all` for the complete computed set of values

`helm get manifest wordpress`

`helm history wordpress`

`helm rollback wordpress 2`

`helm uninstall wordpress --keep-history`