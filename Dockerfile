FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y libc6 libncurses5 libstdc++6 lib32z1 libbz2-1.0

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -qq -y --fix-missing sudo software-properties-common git libxext-dev libxrender-dev libxslt1.1 \
        libxtst-dev libgtk2.0-0 libcanberra-gtk-module unzip wget xkb-data tzdata && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN echo 'Creating user: developer' && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    sudo echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    sudo chmod 0440 /etc/sudoers.d/developer && \
    sudo chown developer:developer -R /home/developer && \
    sudo chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo

RUN apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  apt-get install -y ant && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer;

RUN apt-get update && \
  apt-get install -y ca-certificates-java nano && \
  apt-get clean && \
  update-ca-certificates -f && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer;

RUN echo 'Downloading Android Studio' && \
    wget https://dl.google.com/dl/android/studio/ide-zips/3.0.1.0/android-studio-ide-171.4443003-linux.zip -O /tmp/android-studio.zip -q && \
    echo 'Installing Android Studio' && \
   # mkdir -p /opt/android-studio && \
    unzip /tmp/android-studio.zip -d /opt/ && \
    rm /tmp/android-studio.zip

RUN chmod +x /opt/android-studio/bin/studio.sh && \
    chown developer:developer -R /opt/android-studio && \
    chown developer:developer -R /dev

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
CMD ["su", "-", "developer","/opt/android-studio/bin/studio.sh"]
