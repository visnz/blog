FROM debian
#RUN git clone https://github.com/visnz/blog
ENV OSS_SECRET=$OSS_SECRET
#WORKDIR /blog/
#RUN wget http://gosspublic.alicdn.com/ossutil/1.6.5/ossutil64 && chmod +x ossutil64 \
RUN echo "see here "$OSS_SECRET 