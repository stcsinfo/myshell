#!/bin/bash
mkdir -p /etc/rancher/rke2
nano /etc/rancher/rke2/config.yaml
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="server" INSTALL_RKE2_VERSION="v1.23.7+rke2r2" sh -
systemctl enable rke2-server.service
echo "Si tot es correcte, llença: systemctl start rke2-server.service"
echo "Necesites el token: cat /var/lib/rancher/rke2/server/node-token"
echo "Per seguir logs: journalctl -u rke2-server -f"
