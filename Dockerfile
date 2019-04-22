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

CMD ["newrelic-admin", "run-program", "gunicorn", "monitored.wsgi:application", "--workers=5", "--bind", "0.0.0.0:8000", "--access-logfile", "-", "--error-logfile", "-"]
