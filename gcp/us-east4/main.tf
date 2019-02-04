module "iroha_node" {
  source   = "../modules/iroha-instance"
  name     = "node-us-east4"
  vpc_name = "${var.vpc_name}"
}
