#!/bin/bash

# Navigate to the "Parent" directory
cd ..

# Create a new folder for combined outputs
outputs_folder="./Outputs"
mkdir -p "$outputs_folder"

# Check if the "Model Checker Output" folder exists
if [ -d "TTool/bin/Model Checker Output" ]; then
    model_checker_output_folder="TTool/bin/Model Checker Output"

    # Create a combined output file with time and date
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    combined_output_file="$outputs_folder/Final_Output_SYSML.txt"
    
    # Clear the content of the combined output file
    > "$combined_output_file"

    # Add time and date to the combined output file
    echo "Time and Date: $timestamp" >> "$combined_output_file"
    echo "-------------------------------------------------------------" >> "$combined_output_file"

    # Iterate through the output files in the "Model Checker Output" folder
    for output_file in "$model_checker_output_folder"/*; do
        if [ -f "$output_file" ]; then
            echo "Processing file: $(basename "$output_file")"
            
            # Append the filename to the combined output file
            echo "$(basename "$output_file")" >> "$combined_output_file"
            echo "-------------------------------------------------------------" >> "$combined_output_file"

            # Append the content of the output file to the combined output file
            cat "$output_file" >> "$combined_output_file"
            
            echo "" >> "$combined_output_file"  # Add a line break for better separation
        fi
    done

    echo "Combined output file created: $(basename "$combined_output_file")"
else
    echo "Error: The 'Model Checker Output' folder does not exist in the path."
fi
