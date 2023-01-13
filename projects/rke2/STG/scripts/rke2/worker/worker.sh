#!/bin/bash
mkdir -p /etc/rancher/rke2
nano /etc/rancher/rke2/config.yaml
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_VERSION="v1.21.7+rke2r2" sh -
systemctl enable rke2-agent.service
echo "Si tot és correcte llença: systemctl start rke2-agent.service"
echo "Per seguir logs: journalctl -u rke2-agent -f"
