# Prometheus

## Run this image

```shell
# docker container run -d --name prometheus -p 9090:9090 strund3r/prometheus:2.14
```

Open <http://your_ip:9090> to access the interface of Prometheus.

## View the logs

```shell
# docker container logs -f <container_id>
```

## Create a swarm service

```shell
# docker service create --name prometheus -p 9090:9090 strund3r/prometheus:2.14
```
