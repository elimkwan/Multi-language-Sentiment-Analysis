
from server import app
from flask import request, jsonify

import firebase_admin
from firebase_admin import credentials, db, firestore

firebase_admin.initialize_app()
db = firestore.client()

@app.route('/')
@app.route('/index') #www.alapaca.com/index
def index():
    return "hello world"

@app.route('/create-document')
def create_document():
    try:
        db.collection(u'docs').add({'myfirst':'doc'})
        return "Completed request"
    except Exception as e:
        print(e)
        return 'Could not make request'
    




#www.alpaca.com/ -> hello world
#www.alpaca.com/index -> hellow world
