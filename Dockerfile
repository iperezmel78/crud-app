# Stage 1
FROM docker.io/library/node:19.1-alpine3.16 as builder
ARG BUILD
ENV NODE_OPTIONS="--max_old_space_size=4096" NODE_ENV="production"
WORKDIR /app
COPY . .
RUN npm i && \
  npm cache clean --force && \
  npm run $BUILD

# Stage 2
FROM docker.io/library/nginx:1.23.2-alpine

# support running as arbitrary user which belogs to the root group 
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && \
# users are not allowed to listen on priviliged ports
  sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf && \
# comment user directive as master process is run as user in OpenShift anyhow
  sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

EXPOSE 8081

COPY --from=builder /app/dist/crud-app /usr/share/nginx/html
