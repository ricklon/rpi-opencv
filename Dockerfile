FROM resin/rpi-raspbian:latest  

RUN apt-get update && apt-get install -y --no-install-recommends \
   wget build-essential cmake pkg-config \
   libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev \
   libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
   libxvidcore-dev libx264-dev \
   libgtk2.0-dev libgtk-3-dev \
   libatlas-base-dev gfortran \
   python3-dev python3-pip \

WORKDIR opencv

RUN wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
RUN unzip opencv.zip

RUN wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
RUN unzip opencv_contrib.zip

# Removing the virtualenvwrapper portion for now
# RUN pip install virtualenv virtualenvwrapper
# RUN rm -rf ~/.cache/pip
# RUN source ./bin/virtualenvwrapper 

RUN pip3 install numpy

WORKDIR opencv-3.3.0
RUN mkdir build
WORKDIR build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
    -D BUILD_EXAMPLES=ON ..

#Open your /etc/dphys-swapfile  and then edit the CONF_SWAPSIZE  variable:
#CONF_SWAPSIZE=1024

RUN /etc/init.d/dphys-swapfile stop
RUN /etc/init.d/dphys-swapfile start

RUN make -j3
RUN make install
RUN ldconfig

WORKDIR /usr/local/lib/python3.5/site-packages/
RUN mv cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so




