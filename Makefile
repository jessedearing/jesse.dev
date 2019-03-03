.PHONY: default
default: help


.PHONY: publish
publish: ## Renders the site to static files and publishes them to my S3 bucket
	hugo
	aws s3 sync ./public s3://jesse.dev/

.PHONY: help
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
