#!/bin/bash

die () {
    echo "$1" >&2
    exit -1
}

grep -Fxq "Revolution51" /proc/asound/card1/id || die "use Revolution51 PCI card in slot 1 or reconfigure in PiFmRds/hw-setup.sh and PiFmRds/rds_play"
amixer -qD hw:1 sset "PCM Headphone" -- -15dB || die "failed to set audio level"
