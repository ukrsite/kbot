APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := ukrsite
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS := linux
TARGETARCH := amd64

.PHONY: all linux arm macos windows format lint test get build image push clean

all: linux arm macos windows

linux:
	@echo "Building for Linux..."
	TARGETOS=linux TARGETARCH=amd64 make build

arm:
	@echo "Building for ARM..."
	TARGETOS=linux TARGETARCH=arm make build

macos:
	@echo "Building for macOS..."
	TARGETOS=darwin TARGETARCH=amd64 make build

windows:
	@echo "Building for Windows..."
	TARGETOS=windows TARGETARCH=amd64 make build

format:
	@echo "Running format..."
	gofmt -s -w ./

lint:
	@echo "Running lint..."
	golint

test:
	@echo "Running tests..."
	go test -v

get:
	@echo "Running go get..."
	go get

build: format get
	@echo "Building..."
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/ukrsite/kbot/cmd.appVersion=${VERSION}"

image: build
	@echo "Building Docker image..."
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH}

push: image
	@echo "Pushing Docker image..."
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	@echo "Cleaning up..."
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
