#!/bin/bash

current=$(pwd)  # Save the current directory
cd ..
cd Scenarios || exit
need=$(pwd)
cd ..
cd Models || exit

# Create a separate folder for the output files
mkdir -p "Output_Files/Good_Scen_Output"
mkdir -p "Output_Files/Bad_Scen_Output"

# Create the text file
mkdir -p "OP"
text_file="OP/Final_Output_tina.txt"

# To print the date
current_date=$(date +"%d-%m-%Y")
echo "Current date is: $current_date" >> "$text_file"

# Define function to generate table rows
generate_table_row() {
  local rule_name=$1
  local status=$2
  if [[ "$status" == "Validated!" ]]; then
    status_icon="✅" # Green tick
  else
    status_icon="❌" # Red cross
  fi
  printf "| %-25s | %-15s %s |\n" "$rule_name" "$status_icon">> "$text_file"
}

# Iterate over .ktz files in the ktz_files directory
for ktz_file in ktz_Files/*.ktz; do
  if [[ -f "$ktz_file" ]]; then
    # Check if the current item is a file
    echo "Processing $(basename ${ktz_file})..."
    file=$(basename "$ktz_file") # To extract just the file with extension
    filename="${file%.*}" # To remove the file extension

    echo "----------------------------------------" >> "$text_file"
    echo "${filename}" >> "$text_file"
    echo "" >> "$text_file"

    echo "|          Rule Name         |     Status     |" >> "$text_file"
    echo "|----------------------------|----------------|" >> "$text_file"

    echo "Good Scenarios" >> "$text_file"
    for folder in "$need"/Segregated/Good_Scenarios/*; do
      if [[ "$(basename "${folder%/}")" == "$filename" ]]; then
        for rule in "$folder"/*; do
          rule_name=$(basename "${rule%.*}")
          out_good_dir="Output_Files/Good_Scen_Output/${filename}/${rule_name}"
          mkdir -p "$out_good_dir"
          selt "$ktz_file" "${rule%.*}.ltl" "${out_good_dir}/${rule_name}_good.output"
          if grep -q "FALSE" "${out_good_dir}/${rule_name}_good.output"; then
            generate_table_row "$rule_name" "Error ! ! !"
          else
            generate_table_row "$rule_name" "Validated!"
          fi
        done
      fi
    done
    echo "" >> "$text_file"

    echo "Bad Scenarios" >> "$text_file"
    for folder in "$need"/Segregated/Bad_Scenarios/*; do
      if [[ "$(basename "${folder%/}")" == "$filename" ]]; then
        for rule in "$folder"/*; do
          rule_name=$(basename "${rule%.*}")
          out_bad_dir="Output_Files/Bad_Scen_Output/${filename}/${rule_name}"
          mkdir -p "$out_bad_dir"
          selt "$ktz_file" "${rule%.*}.ltl" "${out_bad_dir}/${rule_name}_bad.output"
          if grep -q "TRUE" "${out_bad_dir}/${rule_name}_bad.output"; then
            generate_table_row "$rule_name" "Error ! ! !"
          else
            generate_table_row "$rule_name" "Validated!"
          fi
        done
      fi
    done
    echo "" >> "$text_file"
  fi
done

echo "Output file 'Final_Output_tina.txt' generated."
echo ""
cd "$current" # Return to the original directory

