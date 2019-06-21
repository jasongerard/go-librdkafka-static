build:
	docker build -t app-build -f Dockerfile . && \
	docker create --name app-container app-build && \
	docker cp app-container:/go/src/app/app.o ./app.o && \
	docker rm -f app-container && \
	docker rmi -f app-build
	
base:
	docker build -t golang-static-base:1.11.4 -f buildbase.Dockerfile .


