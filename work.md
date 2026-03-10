# Docker command setup way

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
