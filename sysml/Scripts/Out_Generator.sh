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
    combined_output_file="$outputs_folder/Combined_Output.txt"
    
    # Clear the content of the combined output file
    > "$combined_output_file"

    # Define function to generate table rows
    generate_table_row() {
        local rule_name=$1
        local status=$2
        if [[ "$status" == "Validated!" ]]; then
            status_icon="✅" # Green tick
        else
            status_icon="❌" # Red cross
        fi
        printf "| %-100s | %-1s %s |\n" "$rule_name" "$status_icon" >> "$table_output_file"
    }

    # Iterate through the output files in the "Model Checker Output" folder
    for output_file in "$model_checker_output_folder"/*; do
        if [ -f "$output_file" ]; then
            echo "Processing file: $(basename "$output_file" .txt)"
            
            # Append the filename (without extension) to the combined output file
            echo "Name of the model: $(basename "$output_file" .txt)" >> "$combined_output_file"
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

# Check if the combined output file exists
if [ -f "$combined_output_file" ]; then
    echo "Combined output file exists: $combined_output_file"

    table_output_file="$outputs_folder/Final_Output_SYSML.txt"

    # Clear the content of the output files
    > "$table_output_file"

    # Add timestamp to the top of the "Final_Output_SYSML" file
    echo "Timestamp: $timestamp" >> "$table_output_file"
    echo ""

    # Iterate through each line of the combined output file
    cat "$combined_output_file" | while IFS= read -r line; do
        # Check if the line has "Name of the model"
        if [[ "$line" == *"Name of the model"* ]]; then
            echo "$line" >> "$table_output_file"
        # Check if the line contains the keyword " -> property is satisfied"
        elif [[ "$line" == *" -> property is satisfied"* ]]; then
            rule_name=$(echo "$line" | awk -F " ->" '{print $1}' | awk '{$1=$1};1')  # Extract the rule name
            generate_table_row "$rule_name" "Validated!"
        # Check if the line contains the keyword " -> property is NOT satisfied"
        elif [[ "$line" == *" -> property is NOT satisfied"* ]]; then
            rule_name=$(echo "$line" | awk -F " ->" '{print $1}' | awk '{$1=$1};1')  # Extract the rule name
            generate_table_row "$rule_name" "Error"
        fi
    done

    echo "Processing completed for all lines."
else
    echo "Error: The combined output file does not exist at the path: $combined_output_file"
fi
