## Terraform module to manage Google Cloud Platform Firewall rules

Creates and manages GCP Firewall rules

**Basic usage**

```hcl
module "gcp_firewall" {
  source = "git@github.com:muresan/terraform-gcp-firewall.git"
  name   = "allow ssh from anywhere"
  network = "test-vpc"
  allow = [
    {
      protocol = "tcp",
      ports = ["22"]
    },
    {
      protocol = "udp",
      ports = ["53"]
    }
  ]
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["my-servers"]
}
```

### Reference
- [Terraform GCP Firewall](https://www.terraform.io/docs/providers/google/r/compute_firewall.html)
- [Terraform Modules](https://www.terraform.io/docs/modules/usage.html)
- [Terraform Interpolation](https://www.terraform.io/docs/configuration/interpolation.html)
