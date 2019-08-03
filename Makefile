img_name := weshofmann/qnap-pseudoraid
container_name := pseudoraid-test
docker_flags := --name $(container_name) --cap-add SYS_ADMIN --cap-add MKNOD --device /dev/fuse
docker_vols := -v /share/DockerData/pseudoraid/config:/config -v /share:/share

all: build
		
start:
	docker run --rm -d $(docker_flags) $(docker_vols) $(img_name)

stop:
	docker stop $(container_name)

run:
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name)

shell:
	docker exec -it $(container_name) /bin/bash

build:
	docker build -t weshofmann/pseudoraid .
