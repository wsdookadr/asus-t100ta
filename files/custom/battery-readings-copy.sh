#!/bin/bash
#
# Note: Only meant to be run inside the homelab
#
ssh t100ta find /var/lib/upower/ -type f | \
grep -v generic | \
xargs -I{} bash -c 'm=$(basename {} | sed -e '\''s/-SR_Real.*$//'\'')".txt"; echo "{} /home/nas/shared/$m"' | \
parallel --no-notice --colsep " " -j1 'scp t100ta:{1} {2} ;'


find /home/nas/shared/history*txt | \
xargs -I{} scp -o StrictHostKeyChecking=no -i ~/.ssh/modern {} root@192.168.1.171:

ssh -o StrictHostKeyChecking=no -i ~/.ssh/modern root@192.168.1.171 'mv history*txt /home/user/ ; chown user:user /home/user/history* ;'
