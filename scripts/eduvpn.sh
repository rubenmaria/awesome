#!/bin/bash
set -e
nmcli connection modify eduVPN connection.interface-name enp4s0
nmcli connection up enp4s0



