all_nodes=(dev-ns-k8s-talos-cp-1 dev-ns-k8s-talos-sn-1 dev-ns-k8s-talos-sn-2 dev-ns-k8s-talos-sn-3)
for node in ${all_nodes[@]}; do
  echo "current node: $node"
  PORT_IDS=$(openstack port list --server $node -f value -c ID)
  echo "ports: $PORT_IDS"
  for PORT_ID in $PORT_IDS; do
    echo "  setting allowed-address on port: $PORT_ID"
    openstack port set $PORT_ID \
      --allowed-address ip-address=172.17.0.0/16 \
      --allowed-address ip-address=172.18.0.0/16
  done
done