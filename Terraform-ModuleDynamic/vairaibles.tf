variable "dc" {
  default = "VMDB"
}

variable "username" {
  default = "administrator@vcenter.lab"
}

variable "password" {
  default = "User@321."
}

variable "server" {
  default = "10.253.253.121"
}

# variable "parent_folder" {
#   default = "Research"
# }

variable "vsphere_cluster" {
  default = "Production-CL"
}

variable "vsphere_datastore" {
  default = "SAN.15K.LUN01"
}

variable "vsphere_network" {
  default = "VM Network"
}

variable "vm_name" {
  default = "UbuntuVM"
}

variable "vm_cpus" {
  default = "4"
}

variable "vm_memory" {
  #memory size in MB
  default = "8192"
}




# variable "child_folder" {   
#   default = "Development"
# }