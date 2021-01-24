
from server import app
from flask import request, jsonify

# from firebase import Firebase
import firebase_admin
from firebase_admin import credentials, db, firestore, storage

from Sentiment.model import analyse

firebase_admin.initialize_app()
db = firestore.client()
storage = storage.bucket("alpaca-72130.appspot.com")

@app.route('/')
@app.route('/index') #www.alapaca.com/index
def index():
    #load the audio file fromt the data base
    blob = storage.blob("audio_recordings/urdu.wav")
    blob.download_to_filename("test.wav")
    sentiment_ans = analyse("./test.wav", "./Sentiment/ada_classifier.model")
    #upload it to database
    try:
        db.collection(u'sentiment').add({'sentiment':sentiment_ans})
        return "Completed request"
    except Exception as e:
        print(e)
        return 'Could not make request'
    