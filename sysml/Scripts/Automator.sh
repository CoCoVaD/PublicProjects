#!/bin/bash

scripts=("TToolInstaller.sh" "MainScript.sh" "Out_Validator.sh")
echo "[Automator Script Running..........]"
for script in "${scripts[@]}"; do
    echo "Running $script .........."
    echo "--------------------------------"
    chmod +x "$script"		#Can be removed in git script.
    ./"$script"
    echo "$script Completed"
done
echo "[Automator Script Completed!]"