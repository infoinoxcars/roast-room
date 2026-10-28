FROM node:22-alpine

WORKDIR /app

# Install wget for healthcheck
RUN apk add --no-cache wget

# Copy project files
COPY . .

# Ensure sessions directory exists and ownership belongs to node user
RUN mkdir -p sessions && chown -R node:node /app

USER node

ENV HOST=0.0.0.0
ENV PORT=4730
ENV NODE_ENV=production

EXPOSE 4730

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3   CMD wget -q --spider http://127.0.0.1:4730/ || exit 1

CMD ["node", "app/server.mjs"]
