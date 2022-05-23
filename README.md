## Terraform creation of all resources

With this repository all the resources necessary for the demo are created.

You should create a service account within AWS with sufficient rights, and 
provide its credentials within the `terraform.tfvars` file.

After that you can execute the commands:

```
$ terraform init
$ terraform apply
```

to have your environment created.
