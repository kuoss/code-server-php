TAG=development
IMAGE=ghcr.io/kuoss/code-server-php:$(TAG)

build:
	docker build -t $(IMAGE) .
