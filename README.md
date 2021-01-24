Sentiment analysis (tone analysis) for voice note data. Details of the training and the models are at `./Sentiment/Preparations/training.ipynb`.

Models:
- CNN
- Ada Boost
- Random Forest

## Dependencies (for model training)
```
Python 3.8
numpy
Cython
librosa
SoundFile
pandas
tensorflow
```

## Deployment Details
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

##### POST Request Locally
```bash
curl -X POST -H 'Content-Type: application/json' -d '{"path": "audio_recordings/rec3.ogg", "user_id": 100}' localhost:5000/
```

