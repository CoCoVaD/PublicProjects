#!/bin/bash

cd ./../TTool/bin || exit 1

# Create a new folder for extracted files in the current location
output_folder="./Model Checker Output"
mkdir -p "$output_folder" || { echo "Error creating output folder."; exit 1; }

# Check if the "Models" folder exists
if [ -d "Models" ]; then
    current_folder="./Models"

    # Loop through each file in the "Models" folder
    for file in "$current_folder"/*; do
        if [ -f "$file" ]; then
            echo "Processing file: $(basename "$file")"
            
            # Create a new output file for each file
            output_file="$output_folder/Output_$(basename "$file").txt"
            
            # Clear the content of the output file
            > "$output_file"

            # Open "modelchecker" and modify the file
            sed -i "1d" modelchecker
            sed -i "1i\set model $file" modelchecker
            sed -i '/action check-syntax/,$ { /action check-syntax/!d }' modelchecker

            # Extracting basename without extension
            file_basename=$(basename "$file")
            file_basename_no_ext="${file_basename%.*}"

            # Creating path for the rule file
            rule_file_path="../../Safety Rules/${file_basename_no_ext}.txt"

            # Checking if rule file exists
            if [ -f "$rule_file_path" ]; then
                echo "Rule file found: $(basename "$rule_file_path")"
                
                # Appending the content of the rule file to "modelchecker" file
                while IFS= read -r rule_line; do
                    echo "action avatar-rg -q \"$rule_line\"" >> modelchecker
                done < "$rule_file_path"

                echo "action quit" >> modelchecker
                echo "Contents of rule file '$file_basename' appended to modelchecker."
            else
                echo "Rule file not found for $(basename "$file")."
            fi

            # Run the ttool-cli.jar command and capture the output
            echo "Running TTool for $(basename "$file")...."
            output=$(java -Xmx2048m -jar ttool-cli.jar -show modelchecker 2>&1)
            echo "Run Successful for $(basename "$file")!"
            # Extract lines following the keyword "Safety Analysis" until a line gap is found
            extraction_started=false
            printf "%s\n" "$output" | while IFS= read -r line; do
                if [[ $extraction_started == true && -n "$line" ]]; then
                    echo "$line" >> "$output_file"
                    extraction_started=false  # Set extraction_started to false after appending the first line
                elif [[ $line == *"Safety Analysis"* ]]; then
                    extraction_started=true
                elif [[ $line == "Exiting. Bye." ]]; then
                    break  # Stop the loop when "Exiting. Bye." is encountered
                fi
            done

            echo "----------------------------------------"
        fi
    done

    echo "All files processed. Extracted files are in the folder $(basename "$output_folder")."
else
    echo "Error: The 'Models' folder does not exist in the path."
fi

