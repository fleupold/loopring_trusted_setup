#!/bin/bash

# Avoid prompt of trusting ssh key fingerprint 
mkdir /root/.ssh/ && touch /root/.ssh/known_hosts
ssh-keyscan sftp.loopring.org > /root/.ssh/known_hosts

#Download previous contribution
sftp -i sftp.credential loopring@sftp.loopring.org <<EOF
reget loopring_mpc_$PREV_CID.zip
exit
EOF

#Contribute with some randomness
cat /dev/urandom | base64 | head -c 100 | python3 contribute.py

#Sign attribution
keybase oneshot
/usr/bin/expect <<EOF
    spawn keybase pgp sign --clearsign -i attestation.txt -o signed_attestation.txt
    expect "command-line signature:"
    send -- "$KEYBASE_PASSWORD\r"; sleep 2
EOF
cat signed_attestation.txt

#Upload contribution
sftp -i sftp.credential loopring@sftp.loopring.org <<EOF
put signed_attestation.txt signed_attestation_$CURR_CID.txt
put loopring_mpc_$CURR_CID.zip
exit
EOF