# DevOps 01
## Creating a Custom Docker Image with Packer in GitHub Actions

[![Custom app Docker Image](https://github.com/endybits/devops-01-app-docker/actions/workflows/create-app-image.yml/badge.svg)](https://github.com/endybits/devops-01-app-docker/actions/workflows/create-app-image.yml)

This is a great starting point. This project introduces you to Packer and Docker, and it helps you set up a basic CI/CD pipeline with GitHub Actions.

Stack ~/> FastAPI | Docker | Packer | Github Actions



Steps:
* Create a simple FastAPI App

  Create a simple [FastAPI Hello World App](https://github.com/endybits/devops-01-app-docker/tree/master/app).
* Dockerize the App
  
  Initially I created a Python Docker using Packer and used this [Dockerfile](https://github.com/endybits/devops-01-app-docker/blob/master/Dockerfile) as a guide for customize it towards my FastAPI image. Also, for my use case it was necessary adopting two approaches: 

  **a) Local Aproach:** in the [docker-fastapi.pkr.hcl](https://github.com/endybits/devops-01-app-docker/blob/master/docker-fastapi.pkr.hcl) file you can find the entire code to create the docker image. Inicially, for local tests I created a compress `app.tar.gz` file from my `app/` directory, using the `tar -czvf app.tar.gz ./app` command in my main project directory.
  When the image was created I used the code `docker run -d --name fastapi-container -p 8000:80 fastapi-image:1.0` to lauch a container and TADAAAA!.

  ![image](https://github.com/endybits/devops-01-app-docker/assets/22806426/993ef457-b44f-4fc8-af79-20e114aacc93)


  **b) Remote and Professional Aproach:** this is the essence of the project. This aproach shows you how to use a Github Actions workflow to package the app in a Docker Image and update it on the Docker Registry when the repo is pushed (**I must explain it in a better way).
  In this exampel, I created a GHA workflow in the [create-app-image.yml](https://github.com/endybits/devops-01-app-docker/blob/master/.github/workflows/create-app-image.yml) file.
  The code contain this steps:
![image](https://github.com/endybits/devops-01-app-docker/assets/22806426/99599549-7532-4f5d-b07b-0a5d95b3103a)

