terraform {
  required_providers {
    nomad = {
      source = "hashicorp/nomad"
      version = "1.4.20"
    }
  }
}

provider "nomad" {
    address = "${var.nomad_server_address}"
#    token = ""
}


resource "nomad_job" "app" {
  purge_on_destroy = true
  jobspec = file("${var.jobspec_path}")
}


variable "nomad_server_address" {
  default = "http://{{.Service.Network.AuthoritativeServer}}:4646"
}

variable "jobspec_path" {}
