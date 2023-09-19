#!/bin/bash

root=$(pwd)  # Save the current directory

echo "[AUTOMATED TESTS] Defining path for tina and selt for further shell commands..."

# Superseeding probcli commands path
# Would recommend editing automation.sh and other scripts to work on paths 
# instead of changing working directory 

chmod +x "$root/eventB/Scripts/ProB/probcli"

echo "Extracting probcli"

probcli() {
    ~/root/eventB/Scripts/ProB/probcli "$@"
}
export -f probcli

echo "Exported Probcli successfully"
# Changing directory so we don't have to edit script calling of automation.sh
cd "$root/eventB/Scripts"

test_script="Automater.sh"

echo "[AUTOMATED TESTS] Calling for test scripts..."
chmod +x "$test_script"		#can be removed when using GitBash
./$test_script