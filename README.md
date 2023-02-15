# L1_Final_Project_EPAM_DevOps_Autumn-2022
# WSGI-application

1. Create a Python Flask aplication named `web_app.py` that will give me pages about/main/user 
`python web_app.py` - run application


![photo_2023-02-02_17-40-21](https://user-images.githubusercontent.com/123692654/216374321-090cc64b-5eb6-4ec2-8d7b-684bf762348f.jpg)

![photo_2023-02-02_17-40-21 (2)](https://user-images.githubusercontent.com/123692654/216374060-a787ba3a-a4d4-4d43-9cb9-220e8d2398b2.jpg)
![photo_2023-02-02_17-40-20](https://user-images.githubusercontent.com/123692654/216374156-49cd906d-6007-483a-bec2-5fbde76af349.jpg)
![photo_2023-02-02_17-40-21 (4)](https://user-images.githubusercontent.com/123692654/216374179-729314d1-bede-459e-9aa8-bb14cb0cfdb9.jpg)


## Create Flask Tests and run them
![photo_2023-02-02_17-40-21 (3)](https://user-images.githubusercontent.com/123692654/216374845-c4f7bc64-98f4-47b6-bad4-4c5079932108.jpg)
```
import os
import tempfile

import pytest

from web_app import app

def test_main():
    client = app.test_client()
    client = client.get('/')
    assert b'Index Page' in client.data

def test_user():
    client = app.test_client()
    client = client.get('/user')
    assert b'User page' in client.data

def test_about():
    client = app.test_client()
    client = client.get('/about')
    assert b'<h1> The About Page</h1>' in client.data
```
## Build Docker image/push it to Docker hub/run docker
Create Dockerfile, Build the image `docker build -f Dockerfile -t app:v0.1.0 .

registry on `https://hub.docker.com/`
- rename my docker image - `docker tag app:v0.1.0 shalimir/webapp:v0.1.0`
- next `docker login`
- next `docker push shalimir/webapp:v0.1.0`
- next `docker rmi <image id> -f` - remove local image
- next `docker run -it -p 5000:5000 shalimir/webapp:v0.1.0` - run docker

