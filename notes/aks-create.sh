#!/bin/bash

az aks create \
    --resource-group teamResources \
    --name team5RBACCluster \
    --network-plugin azure \
    --vnet-subnet-id /subscriptions/03271573-4285-43f4-8557-808369b280af/resourceGroups/teamResources/providers/Microsoft.Network/virtualNetworks/vnet/subnets/vm-subnet \
    --docker-bridge-address 172.17.0.1/16 \
    --dns-service-ip 10.3.0.10 \
    --service-cidr 10.3.0.0/24 \
    --generate-ssh-keys \
    --enable-private-cluster \
    --enable-aad \
    --aad-admin-group-object-ids <changeme-admin-group-object-id>
    --attach-acr /subscriptions/03271573-4285-43f4-8557-808369b280af/resourceGroups/teamResources/providers/Microsoft.ContainerRegistry/registries/registryznl4647