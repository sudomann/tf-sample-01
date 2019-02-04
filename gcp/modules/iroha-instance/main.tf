resource "google_compute_instance" "iroha_instance" {
  name                      = "iroha-${var.name}"
  count                     = "${length(data.google_compute_zones.available.names)}"
  zone                      = "${data.google_compute_zones.available.names[count.index]}"
  description               = "Iroha node suitable for up to 6 peers"
  machine_type              = "custom-1-4864"                                             // custom (1 vCPU, 4.75 GB memory) | 4864/1024 = 4.75
  min_cpu_platform          = "Intel Skylake"
  can_ip_forward            = false
  allow_stopping_for_update = false
  deletion_protection       = false

  tags = ["iroha", "terraform-managed"]

  labels {
    concern   = "backend"
    component = "iroha"

    //role = "iroha-master"
  }

  metadata {
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = "TRUE"
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      type  = "pd-standard"
      size  = "10"                                            // GB
      image = "${data.google_compute_image.ubuntu.self_link}"
    }
  }

  network_interface {
    network = "${var.vpc_name}"

    access_config {
      // Ephemeral IP; See docs about setting static IP
      network_tier = "PREMIUM"
    }
  }

  scheduling {
    preemptible         = false
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  service_account {
    // Default Google Compute Engine service account is used
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
