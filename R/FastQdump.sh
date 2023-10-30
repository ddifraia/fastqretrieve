#!/bin/bash

# Specify the directory containing the SRA accession numbers
directory= $1

# Specify the output directory for FASTQ files
output_directory= $2

# Iterate through each file in the directory
for file in "$1"/*; do
    if [ -f "$file" ]; then
        accession_number=$(basename "$file")
        echo "Processing $accession_number..."

        # Run fasterq-dump on the accession number and save it to the output directory
        fasterq-dump -O "$2" "$accession_number"

        echo "Finished processing $accession_number."
    fi
done
