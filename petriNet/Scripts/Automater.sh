#!/bin/bash

debug="true"			#Write "true" when the output ktz files and Segregated scenarios must be available.

scripts=("Segregator.sh" "ktz_Creator.sh" "Out_Validator.sh")

for script in "${scripts[@]}"; do
    echo "Running $script .........."
    echo "--------------------------------"
    chmod +x "$script"		#Can be removed in git script.
    ./"$script"
    echo "$script Completed"
done

echo "-----------------------------------------------------------------------------------------------"
echo ""

if [[ "$debug" == "true" ]]; then
    echo "Debugging Enabled!"
    echo "-------------------------------------END OF AUTOMATION-------------------------------------"
    
elif [[ "$debug" == "false" ]]; then
    echo "Debugging Disabled!"
    rm -rf "../Scenarios/Segregated"
    rm -rf "../Models/ktz_Files"
    echo "-------------------------------------END OF AUTOMATION-------------------------------------"
    echo ""
fi
