#!/bin/bash
set -e

if [[ -n "$SSH_KEY" ]]; then
  echo "INFO: Allowing key authentication."
  echo $SSH_KEY > /root/.ssh/authorized_keys
else
  echo "INFO: Allowing password authentication."
  echo "root:$SSH_PASSWORD" | chpasswd
fi

echo "INFO: This slave's fingerprint is: `ssh-keygen -l -E md5 -f /etc/ssh/ssh_host_rsa_key`"

echo "INFO: Running $@"
exec $@
