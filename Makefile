# Variables
S6TAG=v3.1.0.1

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build all images
	test -f files/s6-overlay/init || mkdir -p files/s6-overlay
	test -f files/s6-overlay/init || wget -P /tmp https://github.com/just-containers/s6-overlay/releases/download/$(S6TAG)/s6-overlay-noarch.tar.xz
	test -f files/s6-overlay/init || wget -P /tmp https://github.com/just-containers/s6-overlay/releases/download/$(S6TAG)/s6-overlay-x86_64.tar.xz
	test -f files/s6-overlay/init || tar -C files/s6-overlay -Jxpf /tmp/s6-overlay-noarch.tar.xz
	test -f files/s6-overlay/init || tar -C files/s6-overlay -Jxpf /tmp/s6-overlay-x86_64.tar.xz
	docker build -t senet/app-php:8.1-alpine -f ./Dockerfile-8.1-alpine .
