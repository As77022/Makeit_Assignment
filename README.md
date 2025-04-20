# Set Up ClickHouse Environment for Windows
We can use either:
- Use Docker official ClickHouse Image to do the all setup called "clickhouse-server"
- Cloning the ClickHouse official repository and spinning with the help of Docker container.

  # I used these steps for ClickHouse Test Project

## 1. Environment Setup :
 Installed ClickHouse via running below Command Prompt(Windows use) :
```sh
docker run -d --name clickhouse-server -e CLICKHOUSE_USER=myuser -e CLICKHOUSE_PASSWORD=mypassword -e CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 -p 8123:8123 -p 9000:9000 clickhouse/clickhouse-server


## 2. Connect to ClickHouse local server :

