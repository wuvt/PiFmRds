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
```

### Usage

On rds, run both the rds_wuvt and rds_play scripts or install, start, and/or enable the rds_wuvt.service and rds_play.service systemd unit files. Every 20 seconds, rds_wuvt generates an audio file containing the rds signal, and then rds_play plays it. If rds_wuvt ceases to operate correctly, rds_play will continue to output the rds signal with static metadata. If rds_play is taken down or fails, an rds playout file with up-to-date metadata information will be available for use immediately when it comes back up.

As of May 2016, the RDS signal is available via the headphone jack on rds's PCI sound card, with the PCM Headphone control set to 55%, or -15.5 dB gain. The hw-setup.sh script makes sure that this card will be used by rds_play, and that the gain is set correctly. Make sure to run hw-setup.sh before attempting to use rds_play on the primary airchain. If hw-setup.sh fails, you'll need to configure sound card and gain settings manually in hw-setup.sh and rds_play before connecting rds to the STL mux input.

### Todo

The rds encoder has a perfectly fine socket system for feeding it new track data. We just need to actually set up code to grab new track data and feed it into a unix socket, which is...eh, we could get around to it. Unfortunately, realtime rds encoder operation would end up requiring us to either sync ffmpeg, rds, and aplay (running at different sample rates), or add gstreamer support to PiFmRds. Refer back to the above warning regarding "total hacks". I'd argue that this one is the simpler, more stable evil.

Credit for the underlying RDS encoder goes to [Christophe Jacquet](http://www.jacquet80.eu/) (F8FTK).

Copyright 2016, released under the GNU GPL v3.
