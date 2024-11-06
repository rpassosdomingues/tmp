#!/bin/bash

# Habilitar o serviço Wi-Fi
systemctl enable wpa_supplicant.service
systemctl start wpa_supplicant.service

# Ajustar a hora do hardware
hwclock --systohc

# Sincronizar a hora do sistema com um servidor NTP
ntpdate pool.ntp.org
