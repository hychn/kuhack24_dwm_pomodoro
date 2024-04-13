#!/bin/bash
printf "start: $(date +%s)\nstop: $(( $(date +%s) + $1))\n" > timer_data


