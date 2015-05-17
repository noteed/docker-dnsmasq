# Docker image with dnsmasq

    > docker run -d --priviliged dnsmasq
    bcdfe8c3fcf
    > echo "address=/example.local/172.17.0.154" | docker exec -i bcdfe8c3fcf /root/reload.sh
