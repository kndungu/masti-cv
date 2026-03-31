#!/bin/bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

if ! command -v gs >/dev/null 2>&1; then
    echo "Ghostscript (gs) is required to compress PDFs." >&2
    exit 1
fi

# Define input and output filenames as colon-separated pairs.
file_pairs=("cv.pdf:Mastewal_CV.pdf" "coverletter.pdf:Mastewal_CoverLetter.pdf")

for pair in "${file_pairs[@]}"; do
    input="$repo_root/${pair%%:*}"
    output="$repo_root/${pair##*:}"

    if [[ ! -f "$input" ]]; then
        echo "Skipping missing PDF: $input"
        continue
    fi

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input"
done
