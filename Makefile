BUILD_OUT?=awesome-cicd
BUILD_COMMIT?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)
BUILD_TAG?=${BUILD_COMMIT}

export CGO_ENABLED=0
export GO111MODULE=on

# Get application dependencies
.PHONY: dep
dep:
	go get ./...

# Generate code
.PHONY: gen
gen:
	go generate ./...

# Run tests
.PHONY: test
test: TEST_PACKAGES?=./...
test: TEST_FLAGS?=-count=1
test:
	go test ${TEST_FLAGS} ${TEST_PACKAGES}

# Build binary
.PHONY: build
build:
	go build -ldflags "-X main.version=${BUILD_TAG} -X main.commit=${BUILD_COMMIT} ${BUILD_LDFLAGS}" ${BUILD_ARGS} \
		-o ${BUILD_OUT} ./cmd/awesome-cicd

# Install application into /usr/local/bin
.PHONY: install
install: build
	cp ${BUILD_OUT} /usr/local/bin/awesome-cicd

# Lint target runs linter
.PHONY: lint
lint:
	golangci-lint run
