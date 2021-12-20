docker run -d -p 80:80 -e "STREAM=http://stream.morow.com:8080/morow_hi.aacp" \
-e "OUTPUT_DIRECTORY=/usr/share/nginx/html" -e "FORMAT=aac" -e "BITRATES=64:128" -e "PLAYLIST_NAME=morow" \
--name stream2hls lennylip/xiaomi-radio-2-hls