#!/bin/bash

root=$(pwd)  # Save the current directory

echo "[AUTOMATED TESTS] Defining path for tina and selt for further shell commands..."

# Superseeding tina and selt commands path
# Would recommend editing automation.sh and other scripts to work on paths 
# instead of changing working directory 

chmod +x "$root/petriNet/Scripts/tina-3.7.5/bin/tina"
chmod +x "$root/petriNet/Scripts/tina-3.7.5/bin/selt"
chmod +x "$root/petriNet/Scripts/tina-3.7.5/bin/ltl2nc"

tina() {
    ~/work/Projects/Projects/petriNet/Scripts/tina-3.7.5/bin/tina "$@"
}
export -f tina

selt() {
    ~/work/Projects/Projects/petriNet/Scripts/tina-3.7.5/bin/selt "$@"
}
export -f selt

# Changing directory so we don't have to edit script calling of automation.sh
cd "$root/petriNet/Scripts"

test_script="Automater.sh"

echo "[AUTOMATED TESTS] Calling for test scripts..."
chmod +x "$test_script"		#can be removed when using GitBash
./$test_script