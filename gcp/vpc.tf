resource "google_compute_network" "iroha_vpc" {
  name                    = "iroha-vpc"
  description             = "GCP VPC network for iroha"
  auto_create_subnetworks = "true"                      // default is true
  routing_mode            = "REGIONAL"                  //default is REGIONAL
}
