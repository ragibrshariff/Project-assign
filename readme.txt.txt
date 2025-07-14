# Full-Stack Web Application
FastAPI + React (Vite) + MySQL — Dockerized with Docker Compose

This project is a complete containerized application with:
- FastAPI backend
- React frontend built using Vite
- MySQL database
All services are orchestrated via Docker Compose.

============================================================
PROJECT STRUCTURE

project/
├── docker-compose.yml
├── init.sql                  
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── src/,...
├── backend/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── main.py,...

============================================================
 PREREQUISITES

Install the following:
- Docker: https://docs.docker.com/get-docker/
- Docker Compose (usually bundled with Docker Desktop)
- Free ports: 5173 (React), 8000 (FastAPI), 3306 (MySQL)

Verify:
$ docker --version
$ docker compose version

============================================================
 RUNNING LOCALLY

From the root project directory, execute:
$ docker compose up --build -d

This will:
- Build images for backend and frontend
- Initialize MySQL with schema and sample data via init.sql
- Start FastAPI at: http://localhost:8000
- Start React frontend at: http://localhost:5173

============================================================
BACKEND: FastAPI

Dockerfile Summary:
- Uses Python 3.11 base image
- Installs dependencies from requirements.txt
- Starts Uvicorn server on 0.0.0.0:8000

Env variables in docker-compose.yml:
  DB_HOST=db
  DB_USER=user
  DB_PASSWORD=password
  DB_NAME=testdb

Access backend at: http://localhost:8000

============================================================
FRONTEND: React + Vite

Dockerfile Summary:
- Uses Node 20 Alpine base image
- Installs npm dependencies
- Runs Vite dev server on port 5173

Features:
- Hot reload
- Live code volume mount
- Configured with: CHOKIDAR_USEPOLLING=true

Access frontend at: http://localhost:5173

============================================================
DATABASE: MySQL 8.0

Configuration in docker-compose.yml:
  MYSQL_ROOT_PASSWORD: rootpassword
  MYSQL_DATABASE: testdb
  MYSQL_USER: user
  MYSQL_PASSWORD: password

init.sql includes:
- CREATE DATABASE `testdb`
- Creates table `users` with sample data:
    (1, 'sharan'), (2, 'samrudh')
- Grants privileges to `user`

Connect using local clients:
  Host: localhost
  Port: 3306
  User: user
  Password: password
  DB: testdb

============================================================
 DOCKER NETWORK & VOLUMES

All services are on a shared custom network: appnet
Volumes:
- db_data for persistent MySQL storage
- Source code volume mounts for live reloading

============================================================
MAINTENANCE COMMANDS

Start services:
$docker compose up --build -d

Stop services:
$ docker compose down

Stop and remove volumes:
$ docker compose down -v

View logs:
$ docker compose logs

Access container shell:
$ docker exec -it <container_name> bash

CREDITS & CONTACT

Created by: Ragib R Shariff
Tech Stack: FastAPI, React, Vite, MySQL, Docker Compose

Feel free to customize, clone, or extend this project!
