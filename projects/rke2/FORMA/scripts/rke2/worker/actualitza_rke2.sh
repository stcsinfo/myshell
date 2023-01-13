#!/bin/bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_VERSION="v1.21.6+rke2r1" sh -
systemctl restart rke2-agent