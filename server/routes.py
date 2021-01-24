
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

@app.route('/', methods=['GET','POST'])
def index():
    return "hello"

@app.route('/sentimentanalysis', methods=['GET','POST'])
def sentimentanalysis():
    if request.method == 'POST':
        req = request.get_json()
        user_id = req["user_id"]
        path = req["path"]
        blob = storage.blob(path)
        blob.download_to_filename("/tmp/test.ogg")

        value = analyse("/tmp/test.ogg", "./Sentiment/ada_classifier.model")
        print("Result of sentiment analysis: ", value)
        if value is not None:
            data = {
                "sentiment": value,
                "user_id": user_id
            }
            # Change url to command
            res = requests.post('http://localhost:5000/saresults', json=data)
            return res.text
    else:
        return "ERROR"
    return "OK"

@app.route('/saresults', methods=['GET', 'POST'])
def saresults():
    return "Received"
                