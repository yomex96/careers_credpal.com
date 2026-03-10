[![CI/CD Pipeline](https://github.com/yomex96/careers_credpal.com/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/yomex96/careers_credpal.com/actions/workflows/ci-cd.yml)


# careers_credpal.com
# CredPal DevOps Assessment App

A Node.js application demonstrating containerization, PostgreSQL integration, automated testing, and CI/CD pipelines.

---

## 📌 Features

- Node.js API with Express  
- PostgreSQL database (`processes` table)  
- Multi-stage Docker build for production  
- Non-root container user for security  
- Healthcheck and status endpoints (`/health`, `/status`)  
- Jest + Supertest automated tests  
- CI/CD via GitHub Actions with DockerHub image push  

---

## 🛠️ Prerequisites

- [Node.js 20+](https://nodejs.org/)  
- [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/)  
- Git  
- DockerHub account (for CI/CD)

---

## ⚡ Running Locally

1. Clone the repository:

```bash
git clone https://github.com/yomex96/careers_credpal.com.git
cd careers_credpal.com

Install Node.js dependencies:

npm ci

Start the database and app using Docker Compose:

docker-compose up --build

App will be accessible at: http://localhost:3000
Health check: http://localhost:3000/health
Status: http://localhost:3000/status

Run tests locally:

npm test
📦 Docker & Containerization
Dockerfile

Multi-stage build (build + runtime) for smaller production images

Non-root user (appuser) for security

Healthcheck for container monitoring

Tini for proper signal handling

docker-compose.yml

Runs PostgreSQL and Node.js app

Configures environment variables for both services

Uses healthchecks to ensure dependency readiness

🚀 CI/CD Pipeline (GitHub Actions)

Runs on push or pull request to main

Steps:

Checkout repository

Setup Node.js

Install dependencies (npm ci)

Run tests (npm test)

Login to DockerHub

Build Docker image

Push Docker image to DockerHub

Secrets required in GitHub Actions:

DOCKERHUB_USERNAME → Your DockerHub username

DOCKER_PASSWORD → DockerHub Access Token (NOT your password)


## 🔒 Key Decisions

Security:

Non-root user in Docker container

Minimal production dependencies installed in runtime

Environment variables stored in .env and GitHub Secrets

Testing:

Jest + Supertest for API endpoint testing

Mocked database queries to allow CI/CD to run without live DB

CI/CD:

Docker images pushed only on main branch

Pull requests only run tests to prevent unnecessary builds

Containerization Best Practices:

Multi-stage builds to reduce image size

Healthchecks for both app and database services

Tini as init process to handle signals

📝 API Endpoints
Endpoint	Method	Description
/	GET	Test endpoint, returns "CredPal is Working"
/health	GET	Health status of the app (healthy)
/status	GET	Service info and uptime
/process	POST	Add a new data record
/process	GET	List all stored data
/ping	GET	Returns "pong"
🛠️ Run Commands
# Start app in dev mode (hot reload)
npm run dev

# Run tests
npm test

# Build Docker image locally
docker build -t credpal-app:latest .

# Start app + DB locally
docker-compose up --build


DockerHub Repository: https://hub.docker.com/r/yomex96/credpal-app

GitHub Actions: CI/CD workflow file in .github/workflows/ci-cd.yml
