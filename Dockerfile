# Stage 1
FROM docker.io/library/node:18.12.1 as builder
ARG BUILD
WORKDIR /app
COPY . .
RUN npm install
RUN npm run $BUILD

# Stage 2
FROM docker.io/library/nginx:1.23.2-alpine
COPY --from=builder /app/dist/crud-app /usr/share/nginx/html
