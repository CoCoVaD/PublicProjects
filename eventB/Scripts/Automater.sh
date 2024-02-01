#!/bin/bash

debug="false"			#Write "true" when the output files and Segregated scenarios must be available.

scripts=("Segregator.sh" "Out_Validator.sh")

for script in "${scripts[@]}"; do
    echo "Running $script .........."
    echo "--------------------------------"
    chmod +x "$script"		#Can be removed in git script.
    ./"$script"
    echo "$script Completed"
done

echo "-----------------------------------------------------------------------------------------------"
echo "All scripts executed successfully!"
echo ""

if [[ "$debug" == "true" ]]; then
    echo "Debugging Enabled!"
    echo "-------------------------------------END OF AUTOMATION-------------------------------------"
    echo ""
    
elif [[ "$debug" == "false" ]]; then
    echo "Debugging Disabled!"
    rm -rf "../Scenarios/Segregated"
    #rm -rf "../Models/Output_Files"
    echo "-------------------------------------END OF AUTOMATION-------------------------------------"
    echo ""
fi
