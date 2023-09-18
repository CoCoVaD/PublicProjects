#!/bin/bash


current=$(pwd)  # Save the current directory
cd ..
cd Scenarios
need=$(pwd)
cd ..
cd Models || exit

# Directory in which all the Models are saved
#cd /home/goutham/RP/PetriNet\ Models || exit

# Creating a new folder for all the ktz files
ktz_folder="ktz_files"
mkdir -p "$ktz_folder"

# Create a separate folder for the output files and .ktz files
mkdir -p output

# In the output folder, create separate folders for Good and Bad scenarios
outgood="output_good"
mkdir -p "output/$outgood"

outbad="output_bad"
mkdir -p "output/$outbad"

# Read folder names into an array
fold_g=("$need"/Segregated/Good/*/)
fold_b=("$need"/Segregated/Bad/*/)

# Generate .ktz files for all the .ndr files in the folder
for file in *.ndr; do
    # Check if the current item is a file
    if [[ -f "$file" ]]; then
        echo "--------------------------------"
        echo "Generating .ktz file for $file"

        # Generate .ktz file from .ndr file and save it in the ktz_files directory
        tina "$file" "ktz_files/${file%.*}.ktz"
    fi
done


echo ""
echo ""

# Iterate over .ktz files in the ktz_files directory
for ktz_file in ktz_files/*.ktz; do
    # Check if the current item is a file
    if [[ -f "$ktz_file" ]]; then
        echo "--------------------------------"
        echo "Processing $ktz_file"
        filename=$(basename "$ktz_file")       # To extract just the filename with extension
        file="${filename%.*}"                   # To remove the file extension
        echo ""
        echo "Good Scenarios"
        no_error_found_g=true
        for folder in "${fold_g[@]}"; do
            if [[ "$(basename "${folder%/}")" == "$file" ]]; then
                for rule in "$folder"/*; do
                    echo "Processing rule: $rule"
                    selt "$ktz_file" "$rule" "output/${outgood}/${file}_good.output"
                    if grep -q "FALSE" "output/${outgood}/${file}_good.output"; then
                        echo -e "\e[31mError: Found 'FALSE' in ${file}_good.output\e[0m"
                        no_error_found_g=false
                    fi
                done
                echo "Scenarios Validated and Output files are generated"
            fi
        done
        if [ "$no_error_found_g" = true ]; then
            echo -e "\e[32mNo errors found in ${file}_good.output\e[0m"
        fi
        
        echo ""

        echo "Bad Scenarios"
        no_error_found_b=true
        for folder in "${fold_b[@]}"; do
            if [[ "$(basename "${folder%/}")" == "$file" ]]; then
                for rule in "$folder"/*; do
                    echo "Processing rule: $rule"
                    selt "$ktz_file" "${rule%.*}.ltl" "output/${outbad}/${file}_bad.output"
                    if grep -q "TRUE" "output/${outbad}/${file}_bad.output"; then
                        echo -e "\e[31mError: Found 'TRUE' in ${file}_bad.output\e[0m"
                        no_error_found_b=false
                    fi
                done
                echo "Scenarios Validated and Output files generated"
            fi
        done
        if [ "$no_error_found_b" = true ]; then
            echo -e "\e[32mNo errors found in ${file}_bad.output\e[0m"
        fi
    fi
done
echo ""
cd "$current"  # Return to the original directory
