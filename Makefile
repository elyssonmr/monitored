install:
	pip install -r requirements.txt

config-newrelic:
	newrelic-admin generate-config ${KEY} newrelic.ini

run:
	docker-compose up -d
	docker exec -it my-application python manage.py migrate
