# Docker command

# Start the Database
docker run -d \
  --name db \
  --network credpal-net \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=credpal_db \
  postgres:16-alpine

# Start your App

  docker run --rm \
  -p 3000:3000 \
  --name credpal-app \
  --network credpal-net \
  -e DATABASE_URL=postgres://postgres:password@db:5432/credpal_db \
  credpal-service:v1


docker run -it --rm \
  --link credpal-db:credpal-db \
  -e DB_HOST=credpal-db \
  -e DB_USER=app \
  -e DB_PASSWORD=changethis123 \
  -e DB_NAME=app \
  -e DB_PORT=5432 \
  -p 3000:3000 \
  credpal-service:v2


  docker compose logs -f work


  docker compose up --build
docker compose logs -f
curl http://localhost:3000
curl -X POST http://localhost:3000/process -H "Content-Type: application/json" -d '{"data":"hello"}'


# CredPal DevOps Assessment App

This repository contains a Node.js application for the CredPal DevOps Engineer assessment.

## Application Endpoints

- `GET /health` – returns health status
- `GET /status` – returns service info
- `POST /process` – inserts a record in the database

---

## Local Setup

1. Install Docker and Docker Compose
2. Run the services:
```bash
docker-compose up --build