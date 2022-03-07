# OCI Kubernetes and Logging Analytics

This project is a OCI Logging Analytics "Hello World" 

This project is composed of:
- Hello World API app in Node.js
- Terraform scripts for Kubernetes Engine
- Deployment manifest for app

## Build the app (optional)

You can use the following image publicly available `fra.ocir.io/fruktknlrefu/hello-api:latest` or build your own image.

To build the image yourself:

Inside folder `api` run the `podman build -t hello-api .`

Tag the image `podman tag hello-api:latest fra.ocir.io/TENANCY_NAMESPACE/hello-api:latest`. Change the URL for the region you are working, `fra`, `lhr`, etc.

Login the image registry with `podman login fra.ocir.io`. User is TENANCY_NAMESPACE/YOUR_EMAIL and the password is the Auth Token you can create for your user.

Push the image `podman push fra.ocir.io/TENANCY_NAMESPACE/hello-api:latest`.

## Provision IaaS

Inside the folder `deploy` run:

Copy the terraform variables `cp terraform.tfvars_template terraform.tfvars` and put your values in `terraform.tfvars`.

Then run the terraform commands:

- `terraform init`
- `terraform plan`
- `terraform apply`

Answer yes to confirm in `plan` and `apply`.

After you deploy successfully your Kubernetes Cluster, run the export on the terraform output to configure kubectl.

## Deploy K8s manifest

Inside `k8s` folder.

Apply manifest files `kubectl apply -f ./`

Finally you can create a port-forwarding with `kubectl port-forward deployment.apps/api-deployment 3000`

Test the application with `curl -s localhost:3000/hello`.