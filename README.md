# Wordpress

Wordpress with Apache 2.4.x and PHP-FPM running in Docker

## Prerequisites

* [Docker](https://www.docker.com/get-started)

## Get Started

### Running Apache 2.4.x and PHP-FPM

```cli
docker-compose up
```

### Or, Running Apache with phpMyAdmin and MariaDB

```cli
docker-compose -f docker-compose.yml -f docker-compose.local.yml up
```

### WordPress Local Setup

Open the terminal. Run the script 'local-build.sh'.

```cli
./<fileName>
```

Open `http://localhost/wp-admin/` in browser,use username `admin` and password `admin` to login.

## WordPress General Guideline

* The highest the plugin download number is better.
* The plugin must still actively develop by author.
* Security vulnerability found in <https://wpvulndb.com/> must be already had security fixes.

## AWS

### CodeBuild

* To allow build environment connect to database / RDS. Make sure its has the right subnets / security groups configured.
* To allow build environment access credential in Secret Manager. Make sure build role has the following policy attached.
  ```
  - Resource: !Ref AppSecretManagerArn
    Effect: Allow
    Action:
      - secretsmanager:GetSecretValue
  ```

### ECS

* WordPress might have slow response. Make sure the healthcheck is configured with longer timeout duration.

