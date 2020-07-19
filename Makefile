DOCKER_IMAGE_TAG=denisvasilik/rust-armv7:nightly-2020-07-12
DOCKER_CONTAINER_NAME=rust-armv7
DATE=2020-07-12
CHANNEL=nightly
TOOLCHAIN=${CHANNEL}-${DATE}
TARGET=armv7-unknown-linux-gnueabihf


all:

build:
	docker build \
		--build-arg TOOLCHAIN=${TOOLCHAIN} \
		--build-arg TARGET=${TARGET} \
		-t ${DOCKER_IMAGE_TAG} \
		-f Dockerfile \
		.

clean:
	docker rm ${DOCKER_CONTAINER_NAME} -f |:
	docker image rm ${DOCKER_IMAGE_NAME} |:

.PHONY: build clean
