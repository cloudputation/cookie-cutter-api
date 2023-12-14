FROM ubuntu:22.04

WORKDIR /app


RUN apt update
RUN apt -y upgrade
RUN apt -y install python3 python3-pip

COPY ./requirements.txt /app/requirements.txt
COPY ./API_VERSION /app/API_VERSION
COPY ./service.py /app/service.py


RUN python3 -m pip install --no-cache-dir --upgrade -r /app/requirements.txt


CMD ["uvicorn", "service:app", "--host", "0.0.0.0", "--port", "{{.Service.Port}}"]
