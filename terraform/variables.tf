variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API endpoint (https://host:8006/)"
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "node_name" {
  type    = string
  default = "proxmox"
}

variable "template_vm_id" {
  type        = number
  description = "VMID of the Debian 13 cloud-init template"
}

variable "vm_id" {
  type    = number
  default = 201
}

variable "vm_name" {
  type    = string
  default = "wg-vpn"
}

variable "datastore_id" {
  type    = string
  default = "raid6-storage"
}

variable "snippets_datastore_id" {
  type    = string
  default = "local"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for ansible user"
}

variable "bridge" {
  type        = string
  description = "Proxmox bridge to attach the VM NIC to"
  default     = "vmbr0"
}
