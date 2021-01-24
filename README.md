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

##### POST request
```bash
curl -X POST -H 'Content-Type: application/json' -d '{"path": "audio_recrec3.ogg", "user_id": 100}' localhost:5000/
```

