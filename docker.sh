#! /bin/bash
docker build --build-arg TMDB_V3_API_KEY="${var.key}" -t netflix .
api_key="${var.key}"
DOCKERUSER="${var.dockerus}"
DOCKER_ACCESS_TOKEN="${var.access}"
docker run netflix:latest
trivy image netflix:latest