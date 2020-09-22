# Packet per second

#!/bin/bash

if [ -z $1 ]; then
        echo "Enter interface name"
        ip -br addr | grep UP
        exit
elif [ -z $2 ]; then
        echo "Enter time interval"
        exit
fi

time=$2     # time
int=$1      # network interface
while true; do
    txpkts_old="`cat /sys/class/net/$int/statistics/tx_packets`"  # sent packets
    rxpkts_old="`cat /sys/class/net/$int/statistics/rx_packets`"  # recv packets
    sleep $time
    txpkts_new="`cat /sys/class/net/$int/statistics/tx_packets`"  # sent packets
    rxpkts_new="`cat /sys/class/net/$int/statistics/rx_packets`"  # recv packets
    txpkts="`expr $txpkts_new - $txpkts_old`"                     # evaluate expressions for sent packets
    rxpkts="`expr $rxpkts_new - $rxpkts_old`"                     # evaluate expressions for recv packets
    echo "tx $txpkts pkts/s - rx $rxpkts pkts/ on interface $int"
done
