#!/bin/bash
# ---------------------------
#$ -S /bin/bash
# job name 
#$ -N HmmBuild_Job
#
# output file
#$ -o HmmBuild_$JOB_ID.out
# error file
#$ -e HmmBuild_$JOB_ID.err
 
#
# pe request
#$ -pe orte 8
#

 
#$ -cwd

mkdir Hmms;
for filn in *.fa; do hmmbuild $filn.hmm $filn; done;
mv *.hmm ./Hmms;
