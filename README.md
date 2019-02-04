# tf-sample-01
## Problem:
Data source `google_compute_zones` ignores or does not inherit `project` defined in a parent module.
I found that I could get around this by hardcoding the the value of `project` in the `google_compute_zones` data block, or setting the the env var `GOOGLE_PROJECT`, but for my use case, I need it defined only once in a parent module and inherited by all child modules.

Relevant file is located at `gcp/modules/iroha-instance/variables.tf`.
Notice that `project` is defined in `gcp/main.tf`

## To reproduce: 
Start from root of repository:
```
$ terraform init
Initializing modules...
- module.gcp
- module.gcp.us-east4
- module.gcp.us-east4.iroha_node

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Then when you run `terraform plan`:

```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_compute_image.ubuntu: Refreshing state...
data.google_compute_zones.available: Refreshing state...

Error: Error refreshing state: 1 error(s) occurred:

* module.gcp.module.us-east4.module.iroha_node.data.google_compute_zones.available: 1 error(s) occurred:

* module.gcp.module.us-east4.module.iroha_node.data.google_compute_zones.available: data.google_compute_zones.available: project: required field is not set
```
