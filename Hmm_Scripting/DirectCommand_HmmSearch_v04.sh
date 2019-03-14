#!/bin/bash
# ---------------------------
#$ -S /bin/bash
# job name 
#$ -N HmmSearch_Job
#
# output file
#$ -o HmmSearch_$JOB_ID.out
# error file
#$ -e HmmSearch_$JOB_ID.err
 
#
# pe request
#$ -pe orte 1
#

 
#$ -cwd

perl HmmSearch_v03.pl;