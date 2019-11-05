# Copyright (c) 2019 Target Brands, Inc. All rights reserved.
#
# Use of this source code is governed by the LICENSE file in this repository.

build: binary-build docker-build

run: build docker-run

test: build docker-example

#################################
######      Go clean       ######
#################################
clean:

	@go mod tidy
	@go vet ./...
	@go fmt ./...
	@echo "I'm kind of the only name in clean energy right now"

#################################
######    Build Binary     ######
#################################
binary-build:

	GOOS=linux CGO_ENABLED=0 go build -o release/git-plugin github.com/go-vela/vela-git

#################################
######    Docker Build     ######
#################################
docker-build:

	docker build --no-cache -t git-plugin:local .

#################################
######     Docker Run      ######
#################################

docker-run:

	docker run --rm \
		-e PARAMETER_REMOTE \
		-e PARAMETER_PATH \
		-e PARAMETER_COMMIT \
		-e PARAMETER_REF \
		-e VELA_NETRC_MACHINE \
		-e VELA_NETRC_USERNAME \
		-e VELA_NETRC_PASSWORD \
		git-plugin:local

docker-example:

	docker run --rm \
		-e PARAMETER_REMOTE=https://github.com/octocat/hello-world.git \
		-e PARAMETER_PATH=home/octocat_hello-world_1 \
		-e PARAMETER_COMMIT=7fd1a60b01f91b314f59955a4e4d4e80d8edf11d \
		-e PARAMETER_REF=refs/heads/master \
		-e VELA_NETRC_MACHINE \
		-e VELA_NETRC_USERNAME \
		-e VELA_NETRC_PASSWORD \
		git-plugin:local