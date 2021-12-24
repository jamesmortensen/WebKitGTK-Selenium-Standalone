# WebKitGTK-Selenium-Standalone

Minrepro of an attempt to get Epiphany and/or MiniBrowser to work with Selenium Standalone server and eventually as a node in a Selenium Grid.

## Building

```
$ docker build -t local/standalone-webkitgtk:latest .
```

## Running

```
$ docker run --rm -it -p 4444:4444 -p 7900:7900 --shm-size 3g local/standalone-webkitgtk:latest
```

## noVNC

View in the browser at http://localhost:7900 (or alternatively start the container with port 5900 open and use VNC Viewer.)


## Debugging

The Selenium Server is throwing an exception saying it cannot find a matching driver. This container image does not yet work with Selenium and is here only for debugging purposes. vim, and a few other tools, are installed to troubleshoot. The start-selenium-standalone.sh script does not generate the config.toml so we can edit and change it while troubleshooting.

Start the selenium server from a terminal:

```
$ /opt/bin/start-selenium-standalone.sh
```



