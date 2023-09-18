#!/bin/bash

current=$(pwd)  			# Save the current directory
cd ..
cd Scenarios || exit

input_folder=$(pwd)   							# Replace with the name of your input folder
output_folder=$(pwd)/Segregated    					# Replace with the name of the output folder

mkdir -p "$output_folder"      						# Create the output folder if it doesn't exist

# Loop through each file in the input folder  --Note-- /* because it is a folder
for input_file in "$input_folder"/*.txt; do
    if [ -f "$input_file" ]; then					# Check if the current item is a file
        filename=$(basename "$input_file")  				# Get the filename without the path
        good_dir="$output_folder/Good_Scenarios/${filename%.*}"		# %.* to remove the extension
        bad_dir="$output_folder/Bad_Scenarios/${filename%.*}"
        
        mkdir -p "$good_dir" "$bad_dir"  				# Create separate subfolders for "GOOD" and "BAD" diriectories as mentioned in the above lines
        
        # Read the input file line by line
        while IFS= read -r line; do
            if [[ "$line" == "GOOD" ]]; then
                good=true
                continue
            elif [[ "$line" == "BAD" ]]; then
                good=false
                continue
            fi
            # The output of $() is taken as the file name with "Rule_" as it's beginning. | is a pipe operator which gives lines name as input for next part where we removed all the symbols
            if [[ "$good" == true ]]; then
                output_file="$good_dir/Rule_$(echo "$line" | tr -dc '[:alnum:]\n\r').ltl"		
            else
                output_file="$bad_dir/Rule_$(echo "$line" | tr -dc '[:alnum:]\n\r').ltl"
            fi
            
            # Write the line to the new output file with ">" being the redirection operator
            echo "$line" > "$output_file"
            
        done < "$input_file"
        
        echo "Segregation of "$filename" completed."
    fi
done
echo -e "\e[32mSegregation Suceessfull\n\e[0m"
cd "$current"  								# Return to the original directory
