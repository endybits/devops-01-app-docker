packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "fastapi" {
  image  = "python:3.9"
  commit = true

}

build {
  name = "devops-project-01"
  sources = [
    "source.docker.fastapi"
  ]


  provisioner "file" {
    source = "requirements.txt"
    destination = "/tmp/requirements.txt"
  }

  provisioner "file" {
    source = "makefile"
    destination = "/tmp/makefile"
  }

  provisioner "file" {
    source = "app.tar.gz"
    destination = "/tmp/app.tar.gz"
  }

  provisioner "shell" {
    inline = [
      "echo \"************************\"",
      "mkdir /app",
      "mv /tmp/requirements.txt /app/",
      "mv /tmp/makefile /app/",
      "cd /app",
      "tar -xf /tmp/app.tar.gz",
      "make install",
      "echo \"************************\"",
    ]

  }

}
