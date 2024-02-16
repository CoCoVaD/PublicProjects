#!/bin/bash

root=$(pwd)  # Save the current directory

echo "[AUTOMATED TESTS] Defining path for sysml for further shell commands..."

# Superseeding probcli commands path
# Would recommend editing automation.sh and other scripts to work on paths 
# instead of changing working directory 

chmod +x -R "$root/sysml"

# Changing directory so we don't have to edit script calling of automation.sh
cd "$root/sysml/Scripts"

test_script="Automator.sh"

echo "[AUTOMATED TESTS] Calling for test scripts..."
./$test_script