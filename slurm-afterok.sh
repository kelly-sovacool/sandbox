#!/usr/bin/env bash
# use slurm dependencies with latency wait

cmd=$(
cat << EOF
sbatch \
    --output="job1.%j.out" \
    --error="job1.%j.err" \
    --cpus-per-task=1 \
    --job-name="job1" \
    --mail-type=BEGIN,END \
    --mem=1g \
    --partition="quick" \
    --time=2:00:00 \
    --wrap "echo $(date '+%T') > outfile1.txt"
EOF
)
echo $cmd
job_id=$(eval $cmd)

# this job runs 1 minute after the previous job completes successfully
echo '#!/bin/bash
cat outfile1.txt
date "+%T"
' | sbatch \
    --output="job2.%j.out" \
    --error="job2.%j.err" \
    --cpus-per-task=1 \
    --job-name="job2" \
    --mail-type=BEGIN,END \
    --mem=1g \
    --partition="quick" \
    --time=2:00:00 \
    --dependency=afterok:$job_id,after:$job_id+1