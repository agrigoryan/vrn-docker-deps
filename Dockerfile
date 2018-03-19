FROM kaixhin/cuda-torch:8.0
MAINTAINER Aram Grigoryan <aram.grigoryan@gmail.com>

# Install depenencies and python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    python-numpy \
    python-matplotlib \
    libmatio2 \
    libgoogle-glog-dev \
    libboost-all-dev \
    python-dev \
    python-tk \
    libcudnn5=5.1.10-1+cuda8.0

RUN pip install --upgrade setuptools
RUN pip install dlib visvis imageio PySide

# Install lua packages
RUN luarocks install xlua &&\
    luarocks install matio

# Build npy4th
WORKDIR /opt
RUN git clone https://github.com/htwaijry/npy4th.git
WORKDIR /opt/npy4th
RUN luarocks make

# Build thpp
WORKDIR /opt
RUN git clone https://github.com/1adrianb/thpp.git
WORKDIR /opt/thpp/thpp
RUN THPP_NOFB=1 ./build.sh

# Build fb.python
WORKDIR /opt
RUN git clone https://github.com/facebook/fblualib
WORKDIR /opt/fblualib/fblualib/python
RUN luarocks make rockspec/*