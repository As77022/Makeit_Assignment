#  ClickHouse Environment Setup for Windows

This project demonstrates how to set up a ClickHouse environment on Windows using Docker, connect it to a database management tool (like DBeaver), and run SQL queries for analysis. This was part of a ClickHouse Test Project involving sample data and analytical SQL queries

---

## 1. Environment Setup :

ClickHouse was set up using the official Docker image. The following command was used to run ClickHouse with a custom username and password:

```sh
docker run -d --name clickhouse-server -e CLICKHOUSE_USER=myuser -e CLICKHOUSE_PASSWORD=mypassword -e CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 -p 8123:8123 -p 9000:9000 clickhouse/clickhouse-server


This command:

- Pulls the official ClickHouse image.

- Creates a container named clickhouse-server.

- Sets up user authentication (myuser / mypassword).

- Exposes ports 8123 (HTTP) and 9000 (native).

---

##  2. Connect to ClickHouse Local Server :
I used DBeaver, a free database management tool, to connect to the ClickHouse server using the credentials provided above. 

---

##  3. Created Tables and Loaded Sample Data :
I created tables by copying the provided SQL table definitions. After the tables were created, I loaded the sample data for analysis.

---

##  4. Solutions to the Questions :
I analyzed the table structures and wrote SQL queries to answer the provided analytical and bonus questions. For the bonus questions, I took help AI assistance (like GitHub Copilot) to write logical solution.

---

##  5. Repository Structure :
To keep everything organized, I created this repository with all the SQL solutions and supporting files.

Steps I followed:

- Cloned the GitHub repository into my local machine (Downloads folder).

- Added all SQL solution files using VS Code (Visual Studio Code).

- Committed and pushed the changes to the repository using Git commands.

---

##  6. Tools Used :
- Docker
- ClickHouse Server
- DBeaver (for SQL query execution)
- Visual Studio Code ( for creating folders and adding the sql query in git repo)
- ChatGPT & Copilot (for finding solution and idea for Bonus questions)

