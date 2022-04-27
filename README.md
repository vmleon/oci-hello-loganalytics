# OCI Kubernetes and Logging Analytics

This project is a OCI Logging Analytics "Hello World" with Kubernetes.

This project is composed of:

- Hello World API app in Node.js (no db connectivity)
- Terraform scripts for Kubernetes Engine
- Deployment manifest for app with terraform helm_release.
- **Work in Progress**: Query the logs in Logging Analytics
- **Work in Progress**: Ingress controller with Load Balancer

## TODO

- Resource Manager package
- Fix Ingress Controller
- `oci_log_analytics_namespace_scheduled_tasks` purge Log Group on Destroy
- Do we need parsers, entities, Sources specific for the hello-api app?

## Logging Analytics

> Requirement: Logging Analytics enabled on the OCI Region.

### Create Logging Analytics Log Group

Go to **Menu** > **Observability & Management** > **Logging Analytics** > **Administration**.

On the left side menu, click on **Log Groups**.

Click **Create Log Group**.

Set the name `LA OKE Monitoring` and create.

Click on the new Log Group and copy its `OCID`.

### Enable access to Log Group with Instance Principal

Create a Dynamic Group called `dynamic-group-oke-node-pool` that matches OKE node pool workers with matching rule:

```
All {instance.compartment.id = '<compartment_ocid>'
```

> You have to replace `<compartment_ocid>` for the compartment OCID where your Kubernetes Cluster is created.

Create a policy to allow access to Log Group with the following rule:

`Allow dynamic-group dynamic-group-oke-node-pool to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment <Logging Analytics LogGroup's compartment_name>`

## Build the app (optional)

> You can use the following image publicly available `fra.ocir.io/fruktknlrefu/hello-api:latest` or build your own image. Jump to next section if you are reusing the public image.

Build the image yourself:

Inside folder `api` run the `podman build -t hello-api .`

Tag the image `podman tag hello-api:latest fra.ocir.io/TENANCY_NAMESPACE/hello-api:latest`. Change the URL for the region you are working, `fra`, `lhr`, etc.

Login the image registry with `podman login fra.ocir.io`. User is TENANCY_NAMESPACE/YOUR_EMAIL and the password is the Auth Token you can create for your user.

Push the image `podman push fra.ocir.io/TENANCY_NAMESPACE/hello-api:latest`.

## Provision IaaS/Helm

Inside the folder `provisioning` run:

Copy the terraform variables `cp terraform.tfvars_template terraform.tfvars`.

Put your credential values in `terraform.tfvars`.

Then run the terraform commands:

- `terraform init`
- `terraform plan`
- `terraform apply`

Answer yes to confirm the `plan` and the `apply`.

After you deploy successfully your Kubernetes Cluster, run the `export KUBECONFIG` pointing to the generated `kubeconfig` file to configure kubectl and helm.

## Manual Test Application

List the helm release with `helm list`.

Follow the steps on the `helm get notes hello-api` to port-forwarding on localhost.

> WIP: Include ingress-nginx-controller

Test the application with `curl -s localhost:3000/hello`.

## Search in Log Explorer

Search:

```
'Log Source' = 'Kubernetes Container Generic Logs' | stats count as logrecords by 'Log Source' | sort -logrecords
```

## Destroy

Before destroy you need to purge logs.

> FIXME: Can it be done with terraform? Not apparently

```
oci log-analytics storage purge-storage-data \
    -c $COMPARTMENT \
    --namespace-name $(oci os ns get --query 'data' | tr -d '\"') \
    --time-data-ended $(date -u +%FT%TZ)
```

> With Web Console:
>
> Go to **Menu** > **Observability & Management** > **Logging Analytics** > **Administration**.
>
> Go on the side menu to **Storage**.
>
> Click the red button **Purge Logs**.
>
> Select your Log Group Compartment.
>
> Click **Purge**.
