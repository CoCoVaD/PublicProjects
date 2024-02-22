#!/bin/bash
cd ./../TTool/bin
# Create a new folder for extracted files in the current location
output_folder="./Model Checker Output"
mkdir -p "$output_folder"

# Check if the "Models" folder exists
if [ -d "Models" ]; then
    current_folder="./Models"

    # Create an array to store file paths
    file_paths=()
    
    for file in "$current_folder"/*; do
        if [ -f "$file" ]; then
            echo "Processing file: $(basename "$file")"
            
            # Add file path to the array
            file_paths+=("$file")

            # Create a new output file for each file_path
            output_file="$output_folder/Output_$(basename "$file").txt"
            
            # Clear the content of the output file
            > "$output_file"

            # Open "modelchecker" and modify the file
            sed -i "1d" modelchecker
            sed -i "1i\set model $file" modelchecker
            output=$(java -Xmx2048m -jar ttool-cli.jar -show modelchecker 2>&1)

            # Extract lines following the keyword "Safety Analysis" until a line gap is found
            extraction_started=false
            printf "%s\n" "$output" | while IFS= read -r line; do
                if [[ $extraction_started == true && -n "$line" ]]; then
                    echo "$line" >> "$output_file"
                elif [[ $line == *"Safety Analysis"* ]]; then
                    extraction_started=true
                elif [[ $extraction_started == true && -z "$line" ]]; then
                    break  # Stop extraction on line gap
                fi
            done

            echo "----------------------------------------"
        fi
    done

    echo "All files processed. Extracted files are in the folder $(basename "$output_folder'")."
else
    echo "Error: The 'Models' folder does not exist in the path."
fi
