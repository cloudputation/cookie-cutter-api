name: CI

on:
  push:
    branches:
      - main

jobs:
  build-service:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{"{{"}} github.actor {{"}}"}}
          password: ${{"{{"}} secrets.DOCKER_GHCR_TOKEN {{"}}"}}

      - name: Build and push Docker image
        run: |
          echo $(pwd)
          sudo docker build -t ghcr.io/{{.Service.Repository.RepoConfig.RepositoryOwner}}/{{.Service.Name}}:latest .
          sudo docker push ghcr.io/{{.Service.Repository.RepoConfig.RepositoryOwner}}/{{.Service.Name}}:latest
