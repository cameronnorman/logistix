setup: build bundle

build:
	docker-compose build

bundle:
	docker-compose run --rm bundle install

shell:
	docker-compose run --rm app ash

console:
	docker-compose run --rm app ash

run:
	docker-compose run --rm --service-ports app rails s -b 0.0.0.0 -p 3000
