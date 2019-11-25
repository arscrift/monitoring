# AlertManager

## Run this image

```shell
# docker container run -d --name alertmanager -p 9093:9093 strund3r/alertmanager:0.19
```

Open <http://your_ip:9093> to access the interface of AlertManager.

## View the logs

```shell
# docker container logs -f <container_id>
```

## Create a swarm service

```shell
# docker service create --name alertmanager -p 9093:9093 strund3r/alertmanager:0.19
```

PS: Edit /etc/alertmanager/config.yml to put your Team's config.
