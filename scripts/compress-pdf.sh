#!/bin/bash
set -e

# Define an array of input and output filenames as space-separated pairs
file_pairs=("cv.pdf:Kinuthia_CV.pdf" "coverletter.pdf:Kinuthia_CoverLetter.pdf")

for pair in "${file_pairs[@]}"; do
    input="/workspaces/cv/${pair%%:*}"
    output="${pair##*:}"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input"
done
