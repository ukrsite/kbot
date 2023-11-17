APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := ukrsite
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS := linux
TARGETARCH := amd64

.PHONY: all linux arm macos windows format lint test get build image push clean

all: linux arm macos windows

linux:
	TARGETOS=linux TARGETARCH=amd64 make build

arm:
	TARGETOS=linux TARGETARCH=arm make build

macos:
	TARGETOS=darwin TARGETARCH=amd64 make build

windows:
	TARGETOS=windows TARGETARCH=amd64 make build

format:
	@echo "Run format here..."
	gofmt -s -w ./

lint:
	@echo "Run lint here..."
	golint

test:
	@echo "Run tests here..."
	go test -v

get:
	@echo "Run get here..."
	go get

build: format get
	@echo "Let's format it"
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/ukrsite/kbot/cmd.appVersion=${VERSION}"

image: build
	@echo "Let's build it"
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH}

push: image
	@echo "Pushing ..."
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	@echo "Cleaning up..."
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
