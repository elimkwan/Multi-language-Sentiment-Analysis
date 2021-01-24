FROM python:3.9 as builder
RUN pip install pipenv
COPY . /tmp/app/
WORKDIR /tmp/app/
RUN pipenv lock --keep-outdated --requirements > requirements.txt && pipenv run python setup.py bdist_wheel


FROM ubuntu:bionic
COPY --from=builder /tmp/app/dist/*.whl .
ARG DEBIAN_FRONTEND=noninteractive
RUN set -xe \
 && apt-get update -q \
 && apt-get install -y -q \
        python3-wheel \
        python3-pip \
        uwsgi-plugin-python3 \
 && python3 -m pip install *.whl \
 && apt-get remove -y python3-pip python3-wheel \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -f *.whl \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /app 
COPY ./server/creds/firebase.json .
ENV GOOGLE_APPLICATION_CREDENTIALS=~/firebase.json
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