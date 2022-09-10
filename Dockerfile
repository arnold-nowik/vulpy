FROM python:3.8.11-slim-buster

RUN apt-get update && apt-get install --no-install-recommends -y  meld python3-flask python3-cryptography python3-geoip2 python3-bcrypt python3-qrcode python3-jsonschema

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt

WORKDIR /vulpy
COPY ./bad/ /vulpy/bad/
COPY ./good/ /vulpy/good/
COPY ./utils/ /vulpy/utils/

WORKDIR /vulpy/bad
RUN /vulpy/bad/db_init.py

ENTRYPOINT ["python3","vulpy.py"]

