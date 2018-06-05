# mitmproxy-rpi3

[![Docker Repository on Quay](https://quay.io/repository/realeyes/mitmproxy-rpi3/status "Docker Repository on Quay")](https://quay.io/repository/realeyes/mitmproxy-rpi3)

[![Updates](https://pyup.io/repos/github/realeyes-media/mitmproxy-rpi3/shield.svg)](https://pyup.io/repos/github/realeyes-media/mitmproxy-rpi3/)

A Docker image for MITMProxy on Raspberry Pi 3 installed from PyPip and built cross-platform with emulation.

Requires:
* Docker installed on your Pi
* Internet connection to pull image (of course)

Try it out on your Pi with this command:

docker run -it -p 8080:8080 -p 8081:8081 --net="host" quay.io/realeyes/mitmproxy-rpi3 mitmweb