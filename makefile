.PHONY: init build debug clean lint fmt

init:
	docker compose down
	docker compose build

build:
	docker compose up build
	docker compose up clean
	docker compose up textlint

debug:
	docker compose up build

clean:
	docker compose up clean

lint:
	docker compose up textlint

fmt:
	docker compose up fmt