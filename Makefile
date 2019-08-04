img_name := weshofmann/qnap-pseudoraid
container_name := qnap-pseudoraid-test
docker_flags := --name $(container_name) --cap-add SYS_ADMIN --cap-add MKNOD --device /dev/fuse 
docker_vols := -v /share/DockerData/qnap-pseudoraid/config:/config -v /share:/share:shared

all: build
		
start: stop build 
	docker run --rm -d $(docker_flags) $(docker_vols) $(img_name)

runshell: stop build 
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name) /bin/bash

stop:
	docker kill $(container_name) || true
	docker rm $(container_name) || true

run: stop build
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name)

shell:
	docker exec -it $(container_name) /bin/bash

build:
	docker build -t $(img_name) .

deploy: build
	docker push $(img_name)
