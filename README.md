Pi-FM-RDS
=========

## WUVT's stripped-down Pi-FM-RDS instance

The WUVT IT Staff grabbed the code from [the original PiFmRds](https://github.com/ChristopheJacquet/PiFmRds) and pulled out all the rpi-specific stuff so we can run it on standard hardware with a 192kHz DAC for injection via one of the FM modulator's mux ports. Unfortunately, this implementation is a total hack (in several ways) and breaks spec because the RDS carrier is not phase-locked with the stereo pilot. That being said, we ran this setup for about 15 years with our previous software configuration and nobody ever complained, so whatever...

### WUVT Deployment

rds currently runs on an Ubuntu 16.04.1 machine managed via wuvt-ansible:

```
ansible-playbook -i "rds," --ask-sudo-pass main.yml
```

You should probably set up an entry in .ssh/config that aliases rds to to actual rds host.

```
Host rds
	ProxyCommand ssh marshall.wuvt.vt.edu nc %h 22
	Hostname deepwater.wuvt.vt.edu
```

### Building Manually

Clone the source repository and run `make`:

```bash
git clone https://github.com/wuvt/PiFmRds
cd PiFmRds
make
./hw-setup.sh
```

### Usage

On rds, run both the rds_wuvt and rds_play scripts or install, start, and/or enable the rds_wuvt.service and rds_play.service systemd unit files. Every 20 seconds, rds_wuvt generates an audio file containing the rds signal, and then rds_play plays it. If rds_wuvt ceases to operate correctly, rds_play will continue to output the rds signal with static metadata. If rds_play is taken down or fails, an rds playout file with up-to-date metadata information will be available for use immediately when it comes back up.

RDS signal is routed from the headphone jack on rds's M-Audio Revolution 5.1 6-channel 24/192 sound card to one of the MUX inputs on the STL driver. The hw-setup.sh script verifies that this the card is in the correct slot to be used by rds_play, and that the gain is set correctly. If hw-setup.sh fails, you'll need to configure sound card and gain settings manually in hw-setup.sh and rds_play before connecting rds to the STL mux input. The rule of thumb for tuning rds's output gain is that toggling RDS signal injection should affect the 90.7FM modulation level by 3%.

### Todo

Due to the presence of an integrated TCP/IP-linked rds encoder in the new optimod, this code as well as the discreet host rds are deprecated as regards to the current direction of primary airchain development. It should be moved into the backup airchain once optimod RDS is configured. This will also fix the stereo pilot phase sync issue.

The PiFmRds code has a perfectly fine socket system for feeding it new track data. We just need to actually set up code to grab new track data and feed it into a unix socket, which is...eh, we could get around to it. Unfortunately, realtime rds encoder operation to remove the need for a temporary audio file and resulting "seams" in the signal would end up requiring us to either sync ffmpeg, rds, and aplay (running at different sample rates), or add gstreamer support to PiFmRds. Refer back to the above warning regarding "total hacks". I'd argue that the current implementation is the simpler, more stable evil.

Credit for the underlying RDS encoder goes to [Christophe Jacquet](http://www.jacquet80.eu/) (F8FTK).

Copyright 2016, released under the GNU GPL v3.
