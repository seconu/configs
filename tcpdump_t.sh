#!/bin/sh

PCAP_FILE="/tmp/userdata/capture-VNPT04466810.pcap"
DURATION=300

# Telegram config
BOT_TOKEN="8237132642:AAHZxUKpBwSrHO3NRaNfHOkYfg7MEbHcFro"
CHAT_ID="-1003748054916"

while true
do
    echo "[+] Start tcpdump..."

    # chạy tcpdump trong background
	chmod 777 /tmp/yaffs/tcpdump
    /tmp/yaffs/tcpdump -i any -nn -s 0 "not net 192.168.1.0/24" -w $PCAP_FILE >/dev/null 2>&1 &
    TCPDUMP_PID=$!
	
    sleep $DURATION

    echo "[+] Stop tcpdump..."
    kill -2 $TCPDUMP_PID
    sleep 2
	
    if pidof cfg_full >/dev/null 2>&1 || pidof cfg_new >/dev/null 2>&1
    then
        echo "[!] Malware detected!"
        /userfs/bin/curl -k -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
            -d chat_id="$CHAT_ID" \
            -d text="Malware !! (cfg_full or cfg_new detected)" \
            >/dev/null 2>&1
    fi
    echo "[+] Upload file to Telegram..."
    /userfs/bin/curl -k -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
        -F chat_id="$CHAT_ID" \
        -F document=@"$PCAP_FILE" >/dev/null 2>&1
    echo "[+] Delete file..."
    rm -rf $PCAP_FILE

done
