# L1_Final_Project_EPAM_DevOps_Autumn-2022
# WSGI-application
![final_project drawio](https://user-images.githubusercontent.com/123692654/221325913-2baddefc-7690-4acd-b430-52313514e0b7.png)

1. Create a Python Flask aplication named `web_app.py` that will give me pages about/main/user 
`python web_app.py` - run application
![Screenshot_1](https://user-images.githubusercontent.com/123692654/221325914-50c7d9da-343c-4a03-a3ce-bd2c4f2998b2.png)
![Screenshot_2](https://user-images.githubusercontent.com/123692654/221325915-a0ba4034-5b06-4a89-99f8-5c47c869a443.png)
![Screenshot_3](https://user-images.githubusercontent.com/123692654/221325917-d2c31e41-b6bd-4114-b5a5-051240316af6.png)


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

