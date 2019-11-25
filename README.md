# Monitoring

Full stack tools for monitoring containers and other stuff forked from [badtuxx/giropops-monitoring](https://github.com/badtuxx/giropops-monitoring) ;)

- Netdata
- Prometheus
- AlertManager
- Docker
- cAdvisor
- Grafana
- Node_Exporter

## Howto

First of all, clone the monitoring repo:

```shell
# git clone https://github.com/arscrift/monitoring.git
```

## Install Docker and create Swarm cluster

```shell
# curl -fsSL https://get.docker.com | sh
# docker swarm init
```

## Install Netdata

```shell
# bash <(curl -Ss https://my-netdata.io/kickstart.sh)
```

Setting Netdata Exporter configuration in Prometheus:

```YAML
# vim conf/prometheus/prometheus.yml
...
- job_name: 'netdata'
    metrics_path: '/api/v1/allmetrics'
    params:
      format: [prometheus]
    honor_labels: true
    scrape_interval: 5s
    static_configs:
         - targets: ['YOUR_IP:19999']
```

## Deploy with Docker Compose

Execute deploy to create the stack of monitoring:

```shell
# docker-compose -p monitoring up -d

Creating network monitoring_default
Creating volume "monitoring_prometheus_data" with default driver
Creating volume "monitoring_grafana_data" with default driver
Creating network monitoring_default
Creating monitoring_prometheus
Creating monitoring_node-exporter
Creating monitoring_alertmanager
Creating monitoring_cadvisor
Creating monitoring_grafana
```

Verify if services are ok:

```shell
# docker ps
```

## Deploy Stack with Docker Swarm

Execute deploy to create the stack of monitoring:

```shell
# docker stack deploy -c docker-compose.yml monitoring

Creating network monitoring_default
Creating service monitoring_prometheus
Creating service monitoring_node-exporter
Creating service monitoring_alertmanager
Creating service monitoring_cadvisor
Creating service monitoring_grafana
```

Verify if services are ok:

```shell
# docker service ls
```

|      ID      |           NAME           |    MODE    | REPLICAS |             IMAGE             |       PORTS      |
| ------------ | ------------------------ | ---------- | -------- | ----------------------------- | ---------------- |
| 2j5vievon95j | monitoring_alertmanager  | replicated |    1/1   | strund3r/alertmanager:0.19    | *:9093->9093/tcp |
| y1kinszpqzpg | monitoring_cadvisor      | global     |    1/1   | google/cadvisor:latest        | *:8080->8080/tcp |
| jol20u8pahlp | monitoring_grafana       | replicated |    1/1   | grafana/grafana:latest        | *:3000->3000/tcp |
| usr0jy4jquns | monitoring_node-exporter | global     |    1/1   | strund3r/node-exporter:0.18.1 | *:9100->9100/tcp |
| zc3qza0bxys7 | monitoring_prometheus    | replicated |    1/1   | strund3r/prometheus:2.14      | *:9090->9090/tcp |

## Access Services in Browser

To access Prometheus interface on browser:

<http://YOUR_IP:9090>

To access AlertManager interface on browser:

<http://YOUR_IP:9093>

To access Grafana interface on browser:

```yml
<http://YOUR_IP:3000>
user: admin
passwd: admin
```

To add plugs edit file monitoring-monitoring/grafana.config

```shell
GF_INSTALL_PLUGINS=plug1,plug2
```

Current plugs grafana-clock-panel,grafana-piechart-panel,camptocamp-prometheus-alertmanager-datasource,vonage-status-panel

Have fun, access the dashboards! ;)

To access Netdata interface on browser:

<http://YOUR_IP:19999>

To access Prometheus Node_Exporter metrics on browser:

<http://YOUR_IP:9100/metrics>

Test if your alerts are ok:

```shell
# docker service rm monitoring_node-exporter
```

Wait some seconds and you will see the integration works fine! Prometheus alerting the AlertManager that alert the Slack that shows it to you! It's so easy and that simple! :D
\
Create new alerts on Prometheus:

```shell
# vim conf/prometheus/alert.rules
```
