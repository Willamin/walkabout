.DEFAULT_GOAL := all

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## build the game
	shards build --no-color

.PHONY: run
run: ## run the game
	bin/walkabout

.PHONY: all
all: ## build and run the game
all: build run
