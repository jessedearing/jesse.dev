.PHONY: publish
publish:
	hugo
	aws s3 sync ./public s3://jessed.io/
