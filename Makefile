.PHONY init start

init:
	docker swarm init

start:
	docker stack deploy -c docker-compose.yml prometheus

service:
	docker service ls
