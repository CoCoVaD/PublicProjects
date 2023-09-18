#!/bin/bash

current=$(pwd)  # Save the current directory
cd ..
cd Scenarios || exit
need=$(pwd)
cd ..
cd Models || exit

# Creating a new folder for all the ktz files
mkdir -p "ktz_Files"

# Read folder names into an array
folder_g=("$need"/Segregated/Good_Scenarios/*)
folder_b=("$need"/Segregated/Bad_Scenarios/*)

# Generate .ktz files for all the .ndr files in the folder
for file in *.ndr; do
    if [[ -f "$file" ]]; then				    # Check if the current item is a file
        echo "Generating .ktz file for $file ..."
        tina "$file" "ktz_Files/${file%.*}.ktz"		# Generate .ktz file from .ndr file and save it in the ktz_files directory
    fi
done

echo -e "\e[32m.ktz Files Created Suceessfull\n\e[0m"
cd "$current"  								# Return to the original directory
