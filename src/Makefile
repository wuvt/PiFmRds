CC = gcc
CFLAGS = -Wall -std=gnu99 -c -g -O3

rds_wav: rds.o waveforms.o rds_wav.o fm_mpx.o
	$(CC) -o rds_wav rds_wav.o rds.o waveforms.o fm_mpx.o -lm -lsndfile

rds.o: rds.c rds.h
	$(CC) $(CFLAGS) rds.c

waveforms.o: waveforms.c waveforms.h
	$(CC) $(CFLAGS) waveforms.c

rds_wav.o: rds_wav.c
	$(CC) $(CFLAGS) rds_wav.c

fm_mpx.o: fm_mpx.c fm_mpx.h
	$(CC) $(CFLAGS) fm_mpx.c

clean:
	-rm *.o
