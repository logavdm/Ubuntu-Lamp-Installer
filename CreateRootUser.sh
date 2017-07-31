#!/bin/bash

EXPECTED_ARGS=1


adduser $1


usermod -aG sudo $1

su - $1

sudo ls -la /root

sudo nano /etc/ssh/sshd_config
