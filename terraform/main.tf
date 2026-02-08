terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.89.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure
}

# Upload cloud-init user-data as a Proxmox snippet
#resource "proxmox_virtual_environment_file" "cloudinit_user_data" {
#  node_name    = var.node_name
#  datastore_id = var.snippets_datastore_id
#  content_type = "snippets"
#
#  source_raw {
#    file_name = "wg-vpn-user-data.yaml"
#    data = templatefile("${path.module}/cloud-init/user-data.yaml", {
#      ssh_public_key = var.ssh_public_key
#    })
#  }
#}

# Clone VM from your Debian 13 template
resource "proxmox_virtual_environment_vm" "wg_vpn" {
  name      = var.vm_name
  node_name = var.node_name
  vm_id     = var.vm_id

  clone {
    vm_id = var.template_vm_id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = 11
  }

  network_device {
    bridge = var.bridge
  }

  initialization {
    # where Proxmox stores the cloud-init drive
    datastore_id = var.datastore_id # e.g. "local-lvm" (or whichever storage you want)

    # DHCP:
    # Option A (recommended): just omit ip_config if your template already uses DHCP
    # Option B: force DHCP explicitly:
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "ansible"
      keys     = [var.ssh_public_key]
    }

    # optional
    dns {
      servers = ["192.168.1.1"]
    }
  }

}

