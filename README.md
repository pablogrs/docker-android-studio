# docker-android-studio

Running version 3.0

to run:

```
 docker run --name android-studio -tdi --net="host" -e DISPLAY=${DISPLAY} --privileged=true -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/username/:/home/developer/ pablogrs/docker-android-studio
```
