# --- Stage 1: Build Stage ---
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy all source files
COPY . .

# --- Stage 2: Production Stage ---
FROM node:20-alpine AS runtime

# Install tini for proper signal handling
RUN apk add --no-cache tini

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only what’s needed
COPY --from=build --chown=appuser:appgroup /app/package*.json ./
COPY --from=build --chown=appuser:appgroup /app/index.js ./
COPY --from=build --chown=appuser:appgroup /app/app ./app

# Install production dependencies only
RUN npm ci --only=production

# Switch to non-root
USER appuser

# Expose app port
EXPOSE 3000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Entrypoint
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "index.js"]