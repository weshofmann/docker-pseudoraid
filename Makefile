img_name := weshofmann/qnap-pseudoraid
container_name := qnap-pseudoraid-test
docker_flags := --name $(container_name) --cap-add SYS_ADMIN --cap-add MKNOD --device /dev/fuse 
docker_vols := -v /share/DockerData/pseudoraid/config:/config -v /share:/share:shared

all: build
		
start:
	docker run --rm -d $(docker_flags) $(docker_vols) $(img_name)

runshell:
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name) /bin/bash

stop:
	docker stop $(container_name)
	docker rm $(container_name)

run:
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name)

shell:
	docker exec -it $(container_name) /bin/bash

build:
	docker build -t $(img_name) .

deploy:
	docker push $(img_name)
