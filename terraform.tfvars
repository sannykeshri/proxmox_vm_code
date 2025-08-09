node_name      = "host1"
template_vmid  = 109
disk_datastore = "data1"
bridge         = "vmbr0"

default_username = "ansible"
default_password = "ChangeMe#2025"

vms = {
  app01 = {
    hostname = "app01"
    ip_cidr  = "192.168.1.101/24"
    gateway  = "192.168.1.1"
    cores    = 2
    memory   = 4096
    disk_gb  = 40
  }
  app02 = {
    hostname = "app02"
    ip_cidr  = "192.168.1.102/24"
    gateway  = "192.168.1.1"
    cores    = 2
    memory   = 4096
    disk_gb  = 40
    # ssh_key  = "ssh-ed25519 AAAA..."
  }
  db01 = {
    hostname = "db01"
    ip_cidr  = "192.168.1.110/24"
    gateway  = "192.168.1.1"
    cores    = 4
    memory   = 8192
    disk_gb  = 80
    #    password = "Another#Pass1"
  }
}