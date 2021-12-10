FROM nginx:alpine
LABEL maintainer="LennyLip"

ENV STREAM "http://stream.morow.com:8080/morow_hi.aacp"
ENV OUTPUT_DIRECTORY "/usr/share/nginx/html"
ENV FORMAT "aac"
ENV PLAYLIST_NAME "morow"
ENV BITRATES "32:64:128"

ADD rootfs/image_setup /image_setup
RUN /bin/sh /image_setup/build.sh && rm -rf /image_setup
ADD shoutcast2hls.sh /

CMD ["/bin/bash", "/entrypoint.sh"]
# CMD ["nginx", "-g", "daemon off;", "&&", "/bin/bash", "/entrypoint.sh"]
