
from server import app
from flask import request, jsonify, redirect, url_for
import requests
# from firebase import Firebase
import firebase_admin
from firebase_admin import credentials, db, firestore, storage

from Sentiment.model import analyse

firebase_admin.initialize_app()
db = firestore.client()
storage = storage.bucket("alpaca-72130.appspot.com")

# @app.route('/')
# @app.route('/index') #www.alapaca.com/index
# def index():
#     #load the audio file fromt the data base
#     blob = storage.blob("audio_recordings/urdu.wav")
#     blob.download_to_filename("test.wav")
#     sentiment_ans = analyse("./test.wav", "./Sentiment/ada_classifier.model")
#     #upload it to database
#     try:
#         db.collection(u'sentiment').add({'sentiment':sentiment_ans})
#         return "Completed request"
#     except Exception as e:
#         print(e)
#         return 'Could not make request'


@app.route('/', methods=['POST'])
def index():
    if request.method == 'POST':
        req = request.get_json()
        user_id = req["user_id"]
        path = req["path"]
        blob = storage.blob(path)
        blob.download_to_filename("/tmp/test.ogg")

        value = analyse("/tmp/ogg.wav", "./Sentiment/ada_classifier.model")
        if value is not None:
            data = {
                "sentiment": value,
                "user_id": user_id
            }
            # Change url to command
            # res = requests.post('http://localhost:5000/test', json=data)
            # return res.text
            #upload it to database
            try:
                db.collection(u'sentiment').add(data)
                return "Completed request"
            except Exception as e:
                print(e)
                return 'Could not make request'

    else:
        return "ERROR"
    return "OK"

# @app.route('/test', methods=['GET', 'POST'])
# def test():
#     return "Received"
                