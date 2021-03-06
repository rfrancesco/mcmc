#!/bin/bash

# Run simulations with GNU Parallel
# Run with argument dry-run to execute parallel --dry-run

BINARY=xising
N_JOBS=3				# number of concurrent jobs
NS=100					# simulation parameters
BETAS=$(echo 0.{4605..4655..10}) 		 
N_MEASURES=125000			 
N_SKIP=1
INIT="0"
LOGFILE=log				# log start/finish to file - TODO: do this with parallel directly 
OUT_NAME="{3}/{1}/ising_{2}"            # output filename string
ARG="./$BINARY $N_MEASURES $N_SKIP {1} {2} 0 {3} ::: $NS ::: $BETAS ::: ${INIT}"	# Command string

if [ "$1" == 'dry' ]; then
	parallel --dry-run $ARG
	exit 0
fi

echo "$BINARY: $(date): Started job: Ns = [${NS}], betas = [$BETAS]" >> $LOGFILE
parallel -j $N_JOBS --bar --results $OUT_NAME $ARG
echo "$BINARY: $(date): Finished job: Ns = [${NS}], betas = [$BETAS]" >> $LOGFILE

