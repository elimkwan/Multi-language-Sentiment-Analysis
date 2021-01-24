FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
RUN set -xe \
&& apt-get update -q \
&& apt-get install -y -q \
        python3-pip \
        uwsgi-plugin-python3
RUN python3 -m pip install firebase-admin
RUN python3 -m pip install requests
RUN python3 -m pip install flask
RUN python3 -m pip install numpy
RUN python3 -m pip install Cython
RUN python3 -m pip install librosa
RUN python3 -m pip install \
      SoundFile\
      pandas

RUN apt-get -y install libsndfile1
RUN mkdir -p /app

COPY ./server/creds/firebase.json .
COPY . /app/
WORKDIR /app/
ENV GOOGLE_APPLICATION_CREDENTIALS=./server/creds/firebase.json
ENTRYPOINT ["/usr/bin/uwsgi", \
            "--master", \
            "--enable-threads", \
            "--die-on-term", \
            "--plugin", "python3"]
CMD ["--http-socket", "0.0.0.0:8000", \
     "--processes", "4", \
     "--chdir", "/app", \
     "--check-static", "static", \
     "--module", "server:app"]

# FROM python:3.8
# COPY . /tmp/app/
# WORKDIR /tmp/app/

# RUN apt-get update -q \
#  && apt-get install -y -q \
#       python3-wheel \
#       python3-pip \
#       uwsgi-plugin-python3
# RUN pip3 install \
#       SoundFile\
#       librosa\
#       numpy\
#       pandas

# RUN pip3 install \
#       flask\
#       firebase-admin
# RUN pip3 install requests
# RUN apt-get install -y server

# RUN mkdir -p /app 

# COPY ./server/creds/firebase.json .
# ENV GOOGLE_APPLICATION_CREDENTIALS=~/firebase.json
# ENTRYPOINT ["/usr/bin/uwsgi", \
#             "--master", \
#             "--enable-threads", \
#             "--die-on-term", \
#             "--plugin", "python3"]
# CMD ["--http-socket", "0.0.0.0:8000", \
#      "--processes", "4", \
#      "--chdir", "/app", \
#      "--check-static", "static", \
#      "--module", "server:app"]


# FROM python:3.8 as builder
# RUN pip install pipenv
# COPY . /tmp/app/
# WORKDIR /tmp/app/
# RUN pipenv lock --keep-outdated --requirements > requirements.txt && pipenv run python setup.py bdist_wheel


# FROM python:3.8
# COPY --from=builder /tmp/app/dist/*.whl .
# ARG DEBIAN_FRONTEND=noninteractive
# RUN set -xe \
#        && apt-get update -q \
#        && apt-get install -y -q \
#        python3-wheel \
#        python3-pip \
#        uwsgi-plugin-python3 \
#        && python3 -m pip install *.whl \
#        && apt-get autoremove -y \
#        && apt-get clean -y \
#        && rm -f *.whl \
#        && rm -rf /var/lib/apt/lists/* \
#        && mkdir -p /app 
# COPY ./server/creds/firebase.json .


# RUN python3 -m pip install \
#       SoundFile\
#       librosa\
#       numpy\
#       pandas

# RUN pip3 install \
#       flask\
#       firebase-admin
# RUN pip3 install requests


# COPY . /app/
# WORKDIR /app/
# ENV GOOGLE_APPLICATION_CREDENTIALS=./server/creds/firebase.json

# ENTRYPOINT ["/usr/bin/uwsgi", \
#        "--master", \
#        "--enable-threads", \
#        "--die-on-term", \
#        "--plugin", "python3"]
# CMD ["--http-socket", "0.0.0.0:8000", \
#        "--processes", "4", \
#        "--chdir", "/app", \
#        "--check-static", "static", \
#        "--module", "server:app"]