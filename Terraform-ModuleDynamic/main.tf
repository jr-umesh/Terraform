terraform {
  required_providers {
    vsphere =  {
        source = "hashicorp/vsphere"
        version = ">=2.0"
    }
  }
}

provider "vsphere" {
    user = var.username
    password = var.password
    vsphere_server = var.server
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = var.dc
}

data "vsphere_resource_pool" "TerraformTest" {
    name = "TerraformTest"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
    name = var.vsphere_cluster
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "san" {
    name = var.vsphere_datastore
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "vmnet" {
    name = var.vsphere_network
    datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "test_vm" {
    name = var.vm_name
    resource_pool_id = data.vsphere_resource_pool.TerraformTest.id
    datastore_id = data.vsphere_datastore.san.id


    num_cpus = var.vm_cpus
    memory = var.vm_memory
    guest_id = "UbuntuGuest"
    wait_for_guest_net_timeout = 0

    disk {
      label = "disk0"
      size = 30
    }

    cdrom {
        datastore_id = data.vsphere_datastore.san.id
        path = "/ISO/ubuntu-22.04.2-desktop-amd64.iso"
    #   path = "${vsphere_datastore.san.path}/ISO/ubuntu-22.04.2-desktop-amd64.iso"
    }

    network_interface {
      network_id = data.vsphere_network.vmnet.id
    }
}

# resource "vsphere_folder" "parent" {
#     path = var.parent_folder
#     type = "vm"
#     datacenter_id = data.vsphere_datacenter.dc.id
# }

# resource "vsphere_folder" "web" {
#     path = "${vsphere_folder.parent.path}/Web"
#     type = "vm"
#     datacenter_id = data.vsphere_datacenter.dc.id
# }

# resource "vsphere_folder" "db" {
#     path = "${vsphere_folder.parent.path}/Databases"
#     type = "vm"
#     datacenter_id = data.vsphere_datacenter.dc.id
# }

# resource "vsphere_folder" "db1" {
#     path = "${vsphere_folder.db.path}/PostGRE"
#     type = "vm"
#     datacenter_id = data.vsphere_datacenter.dc.id
# }

# resource "vsphere_folder" "html" {
#     path = "${vsphere_folder.web.path}/HTML"
#     type = "vm"
#     datacenter_id = data.vsphere_datacenter.dc.id
# }



