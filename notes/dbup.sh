#!/bin/bash

PROJECT_NAME=tripinsights
DBCONTAINER_NAME=sqlcontainer
PASS="piesang@KKK123"

docker network create ${PROJECT_NAME}
docker run -d \
  --network ${PROJECT_NAME} \
  -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=${PASS}" \
  --name ${DBCONTAINER_NAME} \
  -p 1433:1433 \
  mcr.microsoft.com/mssql/server:2017-latest


docker exec ${DBCONTAINER_NAME} /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U SA -P ${PASS} \
  -Q "CREATE DATABASE mydrivingDB"

docker run -d \
  --network ${PROJECT_NAME} \
  --name dataload \
  -e "SQLFQDN=${DBCONTAINER_NAME}" \
  -e "SQLUSER=SA" \
  -e "SQLPASS=${PASS}" \
  -e "SQLDB=mydrivingDB" \
  vyta/data-load:v1

docker exec ${DBCONTAINER_NAME} \
  /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U SA -P '${PASS}' \
  -Q "select * from [mydrivingDB].[dbo].[POIs]"
