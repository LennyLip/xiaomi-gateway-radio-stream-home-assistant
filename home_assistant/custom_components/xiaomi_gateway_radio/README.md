# xiaomi_miio_gateway
Home Assistant Xiaomi Gateway Radio

This is a custom component to play/stop the Network radio in a Xiaomi Gateway

this plays the last played station on the gateway and start/stop docker container with 'shoutcast2hls' name (it contains radio restreamer).

configuration.yaml example
```yaml
media_player:
  - platform: xiaomi_gateway_radio
    host: <ip of gateway>
    token: <gateway token>
```

token is obtained the same way as explained here ->
https://www.home-assistant.io/components/vacuum.xiaomi_miio/#retrieving-the-access-token

alternatively, follow this to get custom radios in the gateway ->
http://ximiraga.ru