
# Dades generals

## PRO

    Plantilla VM: Plantilla Ubuntu 18.04 LTS K8S RKE2 Hibrida
    API (6443,9345): 172.16.200.239 - k8s-pro.$domain_intra_ba 
    INGRESS(443): 172.16.200.219 - k8s-ingress-pro.$domain_pro_ba (Domini *.$domain_pro_ba)
    INGRESS(443): 172.16.200.220 - k8s-ingress-pro.$domain_intra_ba (Domini *.$domain_intra_ba)
    INGRESS(443): 172.16.200.221 - k8s-ingress-stg.$domain_stg_ba (Domini *.$domain_stg_ba)
    INGRESS(443): 172.16.200.214 - k8s-ingress-admin.$domain_intra_ba (Domini *.$domain_intra_ba)
    XARXA NODES: 172.16.202.X
    Rancher: https://rancherk8s.$domain_intra_ba/
    Grup regles FW: SV037_Kubernetes

    DNS

    Domini	                        Entrada             TIPOLOGIA	    Valor
    $domain_intra_ba        K8s-pro                 A       172.16.200.239
    $domain_pro_ba              k8s-ingress-pro         A       172.16.200.219
    $domain_intra_ba        k8s-ingress-pro         A       172.16.200.220
    $domain_stg_ba          K8s-ingress-stg         A       172.16.200.221
    $domain_pro_ba              store                   CNAME   K8s-ingress-pro
    $domain_intra_ba        store                   CNAME   K8s-ingress-pro
    $domain_intra_ba        k8s-ingress-admin       A       172.16.200.214
    $domain_intra_ba        longhorn                CNAME   k8s-ingress-admin
    $domain_stg_ba          emprenedoria            CNAME   K8s-ingress-stg

## STG

    Plantilla VM:  Plantilla Ubuntu 18.04 LTS K8S RKE2 Hibrida
    API(6443,9345): 172.16.200.241 - k8s-stg.$domain_stg_ba
    INGRESS(443): 172.16.200.217 - k8s-ingress-sistemes.$domain_stg_ba (Domini *.$domain_stg_ba)
    XARXA NODES: 172.16.203.X
    Rancher: https://rancherk8s.$domain_stg_ba/
    Grup regles FW: SV037_Kubernetes

    DNS

    Domini	                        Entrada                  TIPOLOGIA   	Valor
    $domain_stg_ba	        K8s-stg	                    A	    172.16.200.241
    $domain_stg_ba	        k8s-ingress-cluster-stg	    A	    172.16.200.217
    $domain_stg_ba	        rancherk8s                  CNAME   K8s-ingress-cluster-stg
