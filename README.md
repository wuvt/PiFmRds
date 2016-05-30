Pi-FM-RDS
=========

## WUVT's stripped-down Pi-FM-RDS instance

The WUVT IT Staff grabbed the code from [the original PiFmRds](https://github.com/ChristopheJacquet/PiFmRds) and pulled out all the rpi-specific stuff so we can run it on standard hardware with a 192kHz DAC for injection via one of the FM modulator's mux ports. Unfortunately, this implementation is a total hack (in several ways) and breaks spec because the RDS carrier is not phase-locked with the stereo pilot. That being said, we ran this setup for about 15 years with our previous software configuration and nobody ever complained, so whatever...

### Build

Clone the source repository and run `make` in the `src` directory:

```bash
git clone https://github.com/wuvt/PiFmRds
cd PiFmRds/src
make clean
make
```

### Usage

On rds, run both the rds_wuvt and rds_play scripts in the src directory. rds_wuvt generates the rds audio file, while rds_play plays it. If rds_wuvt is under maintenance or ceases to operate correctly, rds_play will continue to output the rds signal with static metadata. Systemd unit files coming soon.

As of May 2016, the RDS signal is output via the headphone jack on the PCI DAC, with the PCM Headphone control set to 55%, or -15.5 dB gain.

### omg why are you bundling a static ffmpeg?

As is the custom at WUVT, we have selected the most reliable, rather than the newest, hardware. Or, more honestly, the cheapest. The rds deployment runs on a 32-bit tower which was donated to WUVT, like nearly all of our machines. Because we use CentOS for machines in the airchain, and CentOS 7 does not have i686 support, we include in this repository the official static i686 build of a newer ffmpeg which supports the necessary features.

Credits for the underlying RDS encoder to [Christophe Jacquet](http://www.jacquet80.eu/) (F8FTK).

Copyright 2016, released under the GNU GPL v3.
