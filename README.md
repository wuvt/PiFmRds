Pi-FM-RDS
=========

## WUVT's stripped-down Pi-FM-RDS instance

The WUVT IT Staff grabbed the code from [the original PiFmRds](https://github.com/wuvt/PiFmRds) and pulled out all the rpi-specific stuff so we can run it on physical hardware with a 192kHz DAC for injection via the FM modulator's mux port. Unfortunately, this implementation is a total hack (for multiple reasons) and breaks spec because the RDS carrier is not phase-locked with the stereo pilot.

Clone the source repository and run `make` in the `src` directory:

```bash
git clone https://github.com/wuvt/PiFmRds
cd PiFmRds/src
make clean
make
```

Config instructions tbd.

Credits for the underlying RDS encoder to [Christophe Jacquet](http://www.jacquet80.eu/) (F8FTK).

Copyright 2016, released under the GNU GPL v3.
