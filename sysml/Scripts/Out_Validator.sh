#!/bin/bash

# Define function to generate table rows
generate_table_row() {
  local property=$1
  local status=$2

  if [[ "$status" == "property is satisfied" ]]; then
    status_icon="✅" # Green tick
  else
    status_icon="❌" # Red cross
  fi

  printf "|%-75s|%-3s|\n" "$property" "$status_icon">> "$text_file"
}

# Navigate to the "Parent" directory
cd ..

# Create a new folder for combined outputs
outputs_folder="./Outputs"
mkdir -p "$outputs_folder"

# Check if the "Model Checker Output" folder exists
if [ -d "TTool/bin/Model Checker Output" ]; then
    model_checker_output_folder="TTool/bin/Model Checker Output"

    # Iterate through the output files in the "Model Checker Output" folder
    for output_file in "$model_checker_output_folder"/*; do
        if [ -f "$output_file" ]; then
            echo "Processing file: $(basename "$output_file")"
            
            # Create a text file for each output file
            text_file="$outputs_folder/$(basename "$output_file" .txt).txt"
            > "$text_file"
            
            # Append the filename to the combined output file
            echo "--------------------------------------------------------" >> "$text_file"
            echo "$(basename "$output_file" .txt)" >> "$text_file"
            echo "--------------------------------------------------------" >> "$text_file"

            # Read each line of the output file
            while IFS= read -r line; do
                # Reverse the line
                reversed_line=$(echo "$line" | rev)

                # Extract property and status from the reversed line
                status=$(echo "$reversed_line" | awk -F">-" '{gsub(/^[ \t]+/, "", $1); print $1}')
                property=$(echo "$reversed_line" | awk -F">-" '{gsub(/^[ \t]+/, "", $2); print $2}')
                
                # Generate table row and append to the text file
                generate_table_row "$property" "$status"
            done < "$output_file"
            
            echo "" >> "$text_file"  # Add a line break for better separation
            echo "Table file created: $(basename "$text_file")"
        fi
    done

    echo "All files processed."
else
    echo "Error: The 'Model Checker Output' folder does not exist in the path."
fi
