FROM dpokidov/imagemagick:latest-ubuntu

RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository multiverse && \
    apt-get -y update && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt -y install ttf-mscorefonts-installer fontconfig

COPY Arial_Narrow.ttf /usr/share/fonts/truetype/msttcorefonts/
COPY Arial_Narrow_Bold.ttf /usr/share/fonts/truetype/msttcorefonts/

RUN apt-get install -y wget && \
    wget -q -O - https://gist.githubusercontent.com/Blastoise/72e10b8af5ca359772ee64b6dba33c91/raw/2d7ab3caa27faa61beca9fbf7d3aca6ce9a25916/clearType.sh | bash && \
    wget -q -O - https://gist.githubusercontent.com/Blastoise/b74e06f739610c4a867cf94b27637a56/raw/96926e732a38d3da860624114990121d71c08ea1/tahoma.sh | bash && \
    wget -q -O - https://gist.githubusercontent.com/Blastoise/64ba4acc55047a53b680c1b3072dd985/raw/6bdf69384da4783cc6dafcb51d281cb3ddcb7ca0/segoeUI.sh | bash && \
    wget -q -O - https://gist.githubusercontent.com/Blastoise/d959d3196fb3937b36969013d96740e0/raw/429d8882b7c34e5dbd7b9cbc9d0079de5bd9e3aa/otherFonts.sh | bash

RUN fc-cache -vr

ENTRYPOINT ["convert"]

RUN groupadd -g 1000 ubuntu
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g 1000 -G sudo -u 1000 ubuntu
RUN touch /home/ubuntu/.sudo_as_admin_successful
RUN touch /home/ubuntu/.hushlogin
RUN chown -R ubuntu:ubuntu /home/ubuntu
USER ubuntu:ubuntu
WORKDIR /home/ubuntu
ENV XDG_RUNTIME_DIR=/home/ubuntu/
