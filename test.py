# test.py
import os

# Define the directory path and file name
directory_path = './eventB/Images'
file_name = 'hello_world.txt'

# Combine the directory path and file name to create the full file path
file_path = f'{directory_path}/{file_name}'

if __name__ == "__main__":
    # Check if the directory exists, create it if not
    if not os.path.exists(directory_path):
        os.makedirs(directory_path)

    # Write "Hello, World!" to the file
    with open(file_path, 'w') as file:
        file.write('Hello, World!')

    print(f'File "{file_name}" created in directory: {directory_path}')
