init:
	rm -rf logistix
	docker-compose run --rm app rails new logistix -T --javascript=webpack --css=tailwind --skip-active-record --skip-hotwire --skip-jbuilder --skip-action-mailer --skip-action-mailbox —skip-action-text --skip-active-job --skip-active-storage

setup: build bundle

build:
	docker-compose build

bundle:
	docker-compose run --rm app bundle install

shell:
	docker-compose run --rm app ash

console:
	docker-compose run --rm app rails c

run:
	rm -f tmp/pids/server.pid
	docker-compose run --rm --service-ports app rails s -b 0.0.0.0 -p 3000
