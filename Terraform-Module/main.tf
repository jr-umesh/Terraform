#Terraform Block
#Tells Terraform what exactly we are working with
terraform {
  required_providers {
    vsphere = {
        source = "hashicorp/vsphere"
        version = ">=2.0"
    }
  }
}


#Provider Block (Includes details about the providers i.e credentials)
provider "vsphere" {
  user = "administrator@vcenter.lab"
  password = "User@321."
  vsphere_server = "10.253.253.121"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  
}

resource "vsphere_folder" "parent" {
  path = "TestVM"
  type = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "web" {
  path = "${vsphere_folder.parent.path}/web"
  type = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
