
VERSION?=latest

build:
	docker build --build-arg VERSION=$(VERSION) -t keyopt/fossil-scm:$(VERSION) .

buildx:
	docker buildx build --no-cache --platform linux/amd64,linux/arm64,linux/386,linux/arm/v7,linux/arm/v6 --build-arg VERSION=$(VERSION) -t keyopt/fossil-scm:$(VERSION) --push .

push:
	docker push keyopt/fossil-scm:$(VERSION)

pushx:
	docker push --platform linux/amd64,linux/arm64,linux/386,linux/arm/v7,linux/arm/v6 keyopt/fossil-scm:$(VERSION)
