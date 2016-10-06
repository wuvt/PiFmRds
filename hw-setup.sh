#!/bin/bash

die () {
    echo "$1" > &2
    exit -1
}

grep -Fxq "Revolution51" /proc/asound/card1/id || die "use Revolution51 PCI card or reconfigure in PiFmRds/hw-setup.sh"
amixer -qD hw:1 sset "PCM Headphone" -- -15dB || die "failed to set audio level"
