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

      - name: Build and push Docker image
        run: |
          echo $(pwd)
          sudo docker build -t ghcr.io/{{.Service.Repo.RepositoryOwner}}/{{.Service.Name}}:latest .
          sudo docker push ghcr.io/{{.Service.Repo.RepositoryOwner}}/{{.Service.Name}}:latest
