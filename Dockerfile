# Stage 1
FROM docker.io/library/node:19.1.0 as builder
ARG BUILD
WORKDIR /app
COPY . .
RUN npm install
RUN npm run $BUILD

# Stage 2
FROM docker.io/library/nginx:1.23.2-alpine

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx

# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf
EXPOSE 8081

# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

COPY --from=builder /app/dist/crud-app /usr/share/nginx/html
