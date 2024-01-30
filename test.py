# Define the directory path and file name
directory_path = './eventB/Images'
file_name = 'hello_world.txt'

# Combine the directory path and file name to create the full file path
file_path = f'{directory_path}/{file_name}'

# Write "Hello, World!" to the file
with open(file_path, 'w') as file:
    file.write('Hello, World!')

print(f'File "{file_name}" created in directory: {directory_path}')
