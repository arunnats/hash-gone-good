#!/bin/bash
# Our own benchmark file to test against jaffars algorithm 

# Redirect all output to run-benchmark.res
exec > run-benchmark.res 2>&1

# sigma protocol 
echo -e "\nSIGMA with assoc, with col: running..."
time make sigma=1 col=1 > LOG_sigma_col.txt
grep RESULT LOG_sigma_col.txt
 
# s_ike
echo -e "\nSimplified IKE with assoc, with col: running..."
time make ike_s=1 col=1 > LOG_ikeS_col.txt
grep RESULT LOG_ikeS_col.txt

# ike protocol
echo -e "\nIKE with assoc, with col: running..."
time make ike=1 col=1 > LOG_ike_col.txt
grep RESULT LOG_ike_col.txt

# List generated log files
echo -e "\nGenerated log files:"
ls -1 LOG_*.txt 2>/dev/null || echo "No LOG files found"