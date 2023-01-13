#!/bin/bash
helm repo update
helm fetch rancher-stable/rancher
helm get values rancher -n cattle-system -o yaml > rancher-values.yaml
helm upgrade rancher rancher-stable/rancher \
  --namespace cattle-system \
  -f rancher-values.yaml \
  --version=2.6.2