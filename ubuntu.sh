sudo nft add table inet excludeTraffic
sudo nft add chain inet excludeTraffic excludeOutgoing { type route hook output priority 0 \; policy accept \; }
sudo nft add rule inet excludeTraffic excludeOutgoing ip daddr 192.168.1.0/24 meta mark set 0x1
sudo sysctl -w net.ipv4.conf.all.rp_filter=2
