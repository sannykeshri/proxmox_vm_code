terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.81.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.1.11:8006/api2/json"
  api_token = "root@pam!ansible_api_token=12c5c10e-215c-46bc-8160-29d461c0e5bb"
  insecure  = true
  ssh {
    agent    = true
    username = "root"
  }
}





#provider "proxmox" {
#  pm_api_url          = "https://192.168.1.11:8006/api2/json"  # Proxmox URL
#  pm_api_token_id     = "root@pam!ansible_api_token"           # Your API token ID
#  pm_api_token_secret = "12c5c10e-215c-46bc-8160-29d461c0e5bb" # Your API token secret
#  pm_tls_insecure     = true
#  # false if using valid SSL
#}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each  = var.vms

  name      = each.value.hostname
  node_name = var.node_name
  started   = true

  clone {
    vm_id = var.template_vmid   # must point to a TEMPLATE VMID
    full  = true
  }

  cpu { cores = each.value.cores }

  # memory is a block
  memory {
    dedicated = each.value.memory   # MB
    # floating  = 0                 # optional
  }

  agent { enabled = true }

  initialization {
    # hostname (inside guest) comes from top-level `name`, so remove hostname here

    ip_config {
      ipv4 {
        address = each.value.ip_cidr   # e.g., 192.168.3.101/24
        gateway = each.value.gateway
      }
    }

    dns {
      servers = ["8.8.8.8"]
      # domain  = "example.local"
    }

    user_account {
      username = var.default_username
      password = try(each.value.password, var.default_password)
      # keys   = [...]
    }
  }

  disk {
    datastore_id = var.disk_datastore
    interface    = "scsi0"         # or "virtio0"
    size         = each.value.disk_gb
    iothread     = true
    discard      = "on"
  }

  network_device {
    bridge = var.bridge
    model  = "virtio"
  }

  scsi_hardware = "virtio-scsi-pci"
  machine       = "q35"
}
