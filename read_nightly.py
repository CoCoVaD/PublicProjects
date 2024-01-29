import requests
from io import BytesIO
import zipfile

nightly_link = 'https://nightly.link/CoCoVaD/PublicProjects/workflows/CI-M1-Display/master/eventB-report.zip'

response = requests.get(nightly_link)

if response.status_code == 200:
    # Open the zip file from the content of the response
    with zipfile.ZipFile(BytesIO(response.content), 'r') as zip_ref:
        # Assuming there's a single text file in the zip
        text_file_name = zip_ref.namelist()[0]
        with zip_ref.open(text_file_name) as text_file:
            nightly_content = text_file.read().decode('utf-8')
            # Process the nightly content as needed
            print(nightly_content)
else:
    print(f"Failed to retrieve the nightly content. Status code: {response.status_code}")