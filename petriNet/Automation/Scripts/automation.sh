#!/bin/bash

script1="segx3.sh"
script2="merge1.sh"


echo ""

echo "Running Segregation Script ($script1)"
chmod +x "$script1"		#can be removed when using GitBash
./$script1

echo ""

echo "Running Validation Script ($script2)"
chmod +x "$script2"		#can be removed when using GitBash
./$script2

echo ""
echo "Both scripts were executed successfully."

pwd
cd ..
cd Scenarios || exit
rm -rf Segregated
cd .. 
cd Models || exit
rm -rf ktz_files
rm -rf output

echo "END OF AUTOMATION"

