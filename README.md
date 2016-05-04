Pi-FM-RDS
=========

## WUVT's stripped-down Pi-FM-RDS instance

The WUVT IT Staff grabbed the code from [the original PiFmRds](https://github.com/ChristopheJacquet/PiFmRds) and pulled out all the rpi-specific stuff so we can run it on physical hardware with a 192kHz DAC for injection via one of the FM modulator's mux ports. Unfortunately, this implementation is a total hack (in several ways) and breaks spec because the RDS carrier is not phase-locked with the stereo pilot. That being said, we ran this setup for about 15 years with our previous software configuration and nobody ever complained, so whatever...

### Build

Clone the source repository and run `make` in the `src` directory:

```bash
git clone https://github.com/wuvt/PiFmRds
cd PiFmRds/src
make clean
make
```

### Usage

On rds, run both the rds_wuvt and rds_play scripts. rds_wuvt generates the rds audio file, while rds_play plays it. If rds_wuvt is under maintenance or ceases to operate correctly, rds_play will continue to output the rds signal with static metadata. Systemd unit files coming soon.

Credits for the underlying RDS encoder to [Christophe Jacquet](http://www.jacquet80.eu/) (F8FTK).

Copyright 2016, released under the GNU GPL v3.
