# syntax=docker/dockerfile:1
FROM postgres:bookworm
COPY vaca-db-init.sql /docker-entrypoint-initdb.d/
EXPOSE 5432