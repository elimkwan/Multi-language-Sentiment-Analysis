## General python Flask API template

##### Required installs:
`docker`

##### Install pipenv
`pip3 install pipenv`

#### When you first open the project
Run `pipenv install` in the top level directory

#### User pipenv to install libraries
E.g: `pipenv install <library-name>`

#### Run development server
Run `sh startlocal.sh` in top level directory


## If you started the server using startlocal.sh
#### Test your urls
##### GET request
```bash
curl localhost:5000/endpoint # For local builds
```

##### POST request
```bash
curl -d '{"my_data": "inputs"}' localhost:5000/endpoint
```


## If you want to containerise your workload
#### To build a container:
```bash
docker build -t <container_name> .  # e.g  <container_name> = command-service
```

#### To run a container:
```bash
docker run -p 8000:8000 <container_name> 
```
You can user the same `curl` command to run the command against the container; but replace the port as follows:
```bash
curl localhost:8000/index
```
Note: press Ctrl + C to stop (same thing on both Mac and Windows)dock

## If you started the server using `flask run`
#### Test your urls
##### GET request
```bash
curl localhost:8000/endpoint # For local builds
```

##### POST request
```bash
curl -d '{"my_data": "inputs"}' localhost:8000/endpoint
```


### Troubleshooting
`ModuleNotFoundError: No module named 'x'`
-> Run `pipenv update` then try again

`Error: Could not locate a Flask application. You did not provide the "FLASK_APP" environment variable, and a "wsgi.py" or "app.py" module was not found in the current directory.`
-> Try renaming `main.py` to `app.py` and try again (no idea why this happens 😋)
