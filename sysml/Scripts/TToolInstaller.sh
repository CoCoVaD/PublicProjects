#!/bin/bash

# Assuming this script is in the "Scripts" folder
cd ..

# Clone TTool repository
#git clone https://gitlab.telecom-paris.fr/mbe-tools/TTool.git

# Change directory to TTool
cd TTool

# Compile the code using gradle and javac
make ttool-cli && make ttoolnotest

# Install TTool
make install

# Return to the original directory
cd ..

# Print a message indicating the process is complete
echo "TTool has been cloned, compiled, and installed successfully."

# Make the TTool directory and its subdirectories executable
chmod +x -R TTool

# Copy the "modelchecker" file from Scripts to TTool/bin
cp Scripts/modelchecker TTool/bin/

# Copy the "modelchecker" file and Models folder from Scripts to TTool/bin
cp Scripts/modelchecker TTool/bin/
cp -r Models TTool/bin/
