data "google_compute_zones" "available" {}

data "google_compute_image" "ubuntu" {
  // Canonical, Ubuntu, 18.04 LTS, amd64 bionic image built on 2019-01-22
  name    = "ubuntu-1804-bionic-v20190122"
  project = "ubuntu-os-cloud"
}

variable "name" {}

variable "vpc_name" {}
