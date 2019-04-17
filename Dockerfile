FROM nginx:alpine
ENV BLOG_NAME=blog
WORKDIR /$BLOG_NAME/
COPY public /$BLOG_NAME
RUN echo "user root;events{}http{include /etc/nginx/mime.types;server{listen 80;location / {root /$BLOG_NAME/;}}}" > /etc/nginx/nginx.conf
EXPOSE 80