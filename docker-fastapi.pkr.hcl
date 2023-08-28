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
  changes = [
    "WORKDIR /app",
    "EXPOSE 8000",
    // "CMD [\"uvicorn\", \"app.main:app\", \"--host\", \"0.0.0.0\", \"--port\", \"80\" ]",
    "CMD [\"./app/main.py\"]",
    "ENTRYPOINT [\"python\"]",
  ]

}

build {
  name = "fastapi-image"
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
      "mkdir -p /app",
      "mv /tmp/requirements.txt /app/",
      "mv /tmp/makefile /app/",
      "cd /app",
      "tar -xf /tmp/app.tar.gz",
      "pwd",
      "ls /app",
      "ls /app/*",
      "make install",
      "echo \"************************\"",
    ]

  }

  post-processor "docker-tag" {
  repository = "fastapi-image"
  tags       = ["1.0"]
  only       = ["docker.fastapi"]
}

}
