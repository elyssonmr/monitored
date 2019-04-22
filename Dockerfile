FROM python:3.6-alpine3.9

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev

WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt

RUN apk del build-deps
EXPOSE 8000
