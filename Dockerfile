# Epiphany 3.38.2 is equivalent to Safari 15.0
# Epiphany is built on top of WebKitGTK 2.34.1
# WEBDRIVER=/usr/bin/WebKitWebDriver -p 5555 --host=127.0.0.1
# http://localhost:5555/status -> ready
FROM seleniarm/node-base:latest

USER root

ARG SELUSER_PASS=seluser


#### NODE

# Install the WebKitGTK browsers and WebDriver, but also some helpful tools for debugging/troubleshooting...
RUN sudo apt-get update -y && sudo apt-get install vim telnet nginx procps epiphany-browser webkit2gtk-driver -y \
      && echo seluser:$SELUSER_PASS | sudo chpasswd \
      && echo "alias l='ls -ltr'" >> /home/seluser/.bashrc
      #rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#RUN x11vnc -storepasswd $SELUSER_PASS /home/seluser/.vnc/passwd

# Usually, this is auto-generated, but we've hard-coded it for now for troubleshooting
COPY config.toml /opt/selenium/


RUN echo "WebKitGTK" > /opt/selenium/browser_name

### STANDALONE
#====================================
# Scripts to run Selenium Standalone
#====================================

# This is modified to not run generate_config so we can edit config.toml manually
COPY start-selenium-standalone.sh /opt/bin/start-selenium-standalone.sh

#==============================
# Supervisor configuration file
#==============================
COPY selenium.conf /etc/supervisor/conf.d/

# Copying configuration script generator
COPY generate_config /opt/bin/generate_config

# Boolean value, maps "--relax-checks"
ENV SE_RELAX_CHECKS true

USER seluser

CMD /usr/bin/supervisord


