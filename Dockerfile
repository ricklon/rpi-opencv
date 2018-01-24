FROM resin/rpi-raspbian:latest  

RUN apt-get update && apt-get install -y --no-install-recommends \
   wget build-essential cmake pkg-config \
   libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev \
   libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
   libxvidcore-dev libx264-dev \
   libgtk2.0-dev libgtk-3-dev \
   libatlas-base-dev gfortran \
   python2.7-dev python3-dev python3-pip \

WORKDIR opencv

RUN wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
RUN unzip opencv.zip

RUN wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
RUN unzip opencv_contrib.zip

# Removing the virtualenvwrapper portion for now
# RUN pip install virtualenv virtualenvwrapper
# RUN rm -rf ~/.cache/pip
# RUN source ./bin/virtualenvwrapper 



