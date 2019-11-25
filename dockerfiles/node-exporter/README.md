# NodeExporter

## Run this image

```shell
# docker container run -d --name node-exporter -p 9100:9100 -v /proc:/usr/proc -v /sys:/usr/sys -v /:/rootfs strund3r/node-exporter:0.18.1
```

Open <http://your_ip:9100/metrics> to access the metrics collected by Node-Exporter .

## View the logs

```shell
# docker container logs -f <container_id>
```

## Create a swarm service

```shell
# docker service create --name node-exporter -p 9100:9100 \
   --mount type=bind,src=/proc,dst=/usr/proc \
   --mount type=bind,src=/sys,dst=/usr/sys \
   --mount type=bind,src=/,dst=/rootfs \
   strund3r/node-exporter:0.18.1
```
