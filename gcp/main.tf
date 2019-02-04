provider "google" {
  project = "my-project-name"
  version = "=1.20"
}

provider "google" {
  alias  = "us-east4"
  region = "us-east4"
}

module "us-east4" {
  source   = "us-east4"
  vpc_name = "${google_compute_network.iroha_vpc.name}"

  providers = {
    google = "google.us-east4"
  }
}
