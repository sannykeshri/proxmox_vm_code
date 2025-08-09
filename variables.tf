variable "node_name" {}      # e.g., "pve" (your Proxmox node)
variable "template_vmid" {}  # e.g., 9000 (cloud-init template VMID)
variable "disk_datastore" {} # e.g., "local-lvm"
variable "bridge" {}         # e.g., "vmbr0"

variable "default_username" { default = "ubuntu" }
variable "default_password" {}

# map of VMs to create
variable "vms" {
  type = map(object({
    hostname = string
    ip_cidr  = string # "192.168.3.101/24"
    gateway  = string # "192.168.3.1"
    cores    = number
    memory   = number # MB
    disk_gb  = number # GB
    # optional per-VM override:
    password = optional(string)
    # optional SSH key (string)
    ssh_key = optional(string)
  }))
}
