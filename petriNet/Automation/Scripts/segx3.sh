#!/bin/bash

current=$(pwd)  # Save the current directory
cd ..
cd Scenarios || exit

input_folder=$(pwd)   			# Replace with the name of your input folder
output_folder=$(pwd)/Segregated    # Replace with the name of the output folder

mkdir -p "$output_folder"      # Create the output folder if it doesn't exist

# Loop through each file in the input folder
for input_file in "$input_folder"/*; do
    # Check if the current item is a file
    if [ -f "$input_file" ]; then
        filename=$(basename "$input_file")  # Get the filename without the path
        
        good_dir="$output_folder/Good/${filename%.*}"
        bad_dir="$output_folder/Bad/${filename%.*}"
        
        mkdir -p "$good_dir" "$bad_dir"  # Create separate subfolders for "GOOD" and "BAD" lines
        
        # Read the input file line by line
        while IFS= read -r line; do
            if [[ "$line" == "GOOD" ]]; then
                good=true
                continue
            elif [[ "$line" == "BAD" ]]; then
                good=false
                continue
            fi
            
            if [[ "$good" == true ]]; then
                output_file="$good_dir/segregated_$(echo "$line" | tr -dc '[:alnum:]\n\r').ltl"
            else
                output_file="$bad_dir/segregated_$(echo "$line" | tr -dc '[:alnum:]\n\r').ltl"
            fi
            
            # Write the line to the new output file
            echo "$line" > "$output_file"
            
            echo "Line '$line' segregated to '$output_file'"
        done < "$input_file"
        
        echo "Segregation of '$input_file' completed."
    fi
done

cd "$current"  # Return to the original directory
