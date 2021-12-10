## This project allows you to listen to any radio stream with Xiaomi Mi Radio and Xiaomi Gateway and Home Assistant (optional).

1. First of all, you need to obtain a token of your Xiaomi device.
Easiest way to do this is to add a device to your Xiaomi account with the official Mi Home app and then use [Xiaomi-cloud-tokens-extractor](https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor).
2. Then we need to create [HLS audio playlist](https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming) with a stream which device can recognize. In short, it is the m3u8 HLS playlist that has .aac files inside. To do this we'll create Docker image with nginx and ffmeg based on [Shoutcast2HLS](https://github.com/dehy/shoutcast2hls) project. Thanks to https://github.com/andr68rus/miwifiradio/blob/master/include/ffcontrol.php for ffmpeg params for the playlist.

```
$ cd stream2hls_docker
$ ./build_docker.sh
```

To run docker with morow.com station to transocode to Xiaomi playlist stream run script:

```
$ ./run_docker_morow.sh
```

you can check /usr/share/nginx/html folder inside docker for generated files (m3u8, aac). 

3. Next, you need to send HLS playlist url to Xiaomi Radio device. To do this edit play_morow.sh file: add your token and server ip with docker. To run this script you need to get [php-miio library](https://github.com/skysilver-lab/php-miio). Download or clone php-miio and run play_morow.sh. You should hear sound of your radio station. Addional xiaomi radio commands you can test:

```
{"id":1,"method":"volume_ctrl_fm","params":["99"]} # volume
{"id":1,"method":"play_specify_fm","params":[527782011,50]} # play station from global list [id_station, volume]
{"id":1,"method":"get_channels","params":{"start":0}} # get first 10 favorite channels
{"id":10,"method":"add_channels","params":{"chs":[{"id":1023,"url":"http://192.168.1.5/morow_128k.m3u8","type":0}]}} # add channel to favorites
{"id":10,"method":"set_channels","params":{"chs":[{"id":1023,"url":"http://192.168.1.5/morow_128k.m3u8","type":0}]}} # replace favorites with channels
{"id":1,"method":"play_specify_fm","params":{"id":1,"type":0,"url":"http://192.168.1.5/morow_128k.m3u8"}} # play station from url
{"id":1,"method":"get_prop_fm","params":{}} # get info about current channel (now playing or paused)
```

NB. python-miio not helps us due [this issue](https://github.com/rytilahti/python-miio/issues/629).

4. (Optional) Home assistant component. home_assistant folder contains a custom component for Home Assistant to play/stop, change volume of current radio channel of Xiaomi Gateway device. It's based on [Home Assistant Xiaomi Gateway Radio](https://github.com/h4v1nfun/xiaomi_miio_gateway) project with start\stop docker functional while you stop or start radion (to disable transcoding while you do not listen to the radio). Just copy xiaomi_gateway_radio to the custom component folder, add config strings (see README.md inside component folder) and restart your Home Assistant server. If you use Home Assistant inside docker you need to add /var/run/docker.sock volume to Home Assistant docker image to able to manage dockers containers from the custom component.