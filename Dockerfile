FROM orus/hugo-builder
RUN git clone https://github.com/visnz/blog
WORKDIR /blog/
RUN hugo --config static/config.toml

FROM nginx:alpine
ENV BLOG_NAME=blog
WORKDIR /$BLOG_NAME/
COPY --from=0 /blog/public /$BLOG_NAME
RUN echo "user root;events{}http{include /etc/nginx/mime.types;server{listen 80;location / {root /$BLOG_NAME/;}}}" > /etc/nginx/nginx.conf
EXPOSE 80