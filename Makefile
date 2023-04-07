build:
	docker buildx build -t sam-is-testing:latest .

run:
	docker run -it --rm sam-is-testing