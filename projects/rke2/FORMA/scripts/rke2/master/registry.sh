#!/bin/bash
curl -sLS https://get.arkade.dev | sudo sh
arkade install docker-registry
echo "Introdueix url registre"
read url
echo "Introdueix usuari"
read username
echo "Introdueix password"
read password
echo "Introdueix email"
read email
echo "export DOCKER_REGISTRY=$url" > ~/.bashrc
echo "export DOCKER_REGISTRY=$username" > ~/.bashrc
echo "export DOCKER_REGISTRY=$password" > ~/.bashrc
echo "export DOCKER_REGISTRY=$email" > ~/.bashrc
export DOCKER_REGISTRY=$url
export DOCKER_USERNAME=$username
export DOCKER_PASSWORD=$password
export DOCKER_EMAIL=$email
arkade install docker-registry-ingress --email $DOCKER_EMAIL --domain $DOCKER_REGISTRY
kubectl get ingress docker-registry --output=yaml
kubectl logs -n cert-manager deploy/cert-manager