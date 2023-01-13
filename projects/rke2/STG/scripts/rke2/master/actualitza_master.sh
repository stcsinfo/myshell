#!/bin/bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="server" INSTALL_RKE2_VERSION="v1.23.6+rke2r2" sh -
systemctl restart rke2-server