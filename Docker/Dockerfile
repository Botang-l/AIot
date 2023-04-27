FROM nvidia/cuda:11.4.0-base-ubuntu20.04

ADD . /Docker

RUN mkdir -p /workspace/projects
  
WORKDIR /workspace/projects
ENV workspace=/workspace/projects
ARG UID=1000
ARG GID=1000
ARG NAME=base

ENV INSTALLATION_TOOLS apt-utils \
    sudo \
    curl \
    wget \
    software-properties-common \
    gnupg2

ENV TOOL_PACKAGES dos2unix \
    git \
    nano \
    vim \
    tree \
    locales \
    python3-pip \
    make \
    build-essential \
    nvidia-container-toolkit


# install essential tools and packages
RUN apt-get update -qq && \
    apt-get install ${INSTALLATION_TOOLS} -yqq && \
    add-apt-repository ppa:git-core/ppa

# 安裝nvidia驅動程式
RUN curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list

RUN apt-get update -qq && \
    apt-get upgrade -yqq && \
    apt-get install ${TOOL_PACKAGES} -yqq

# Change time zone
RUN apt-get install -yqq --no-install-recommends tzdata
RUN TZ=Asia/Taipei \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN groupadd -g $GID -o $NAME

RUN useradd -u $UID -m -g $NAME -G plugdev $NAME && \ 
	echo "$NAME ALL = NOPASSWD: ALL" > /etc/sudoers.d/user && \
	chmod 0440 /etc/sudoers.d/user

RUN chown -R $NAME:$NAME /home/$NAME
RUN chown -R $NAME:$NAME /Docker

# Install required python modules
RUN pip3 install -r /Docker/requirements.txt

# add a test file
RUN echo "import torch" > test.py && \
    echo "print(torch.cuda.is_available())" >> test.py

# Convert .sh files from CRLF to LF
RUN dos2unix -ic /Docker/start.sh | xargs dos2unix
RUN dos2unix -ic /Docker/env_setup.sh | xargs dos2unix

RUN cp /Docker/start.sh /usr/local/bin/ && chmod 755 /usr/local/bin/start.sh
USER $NAME
RUN echo eval /usr/local/bin/start.sh > ~/.bashrc 
RUN echo "export PS1=\"\[\e[0;31m\]\u@\[\e[m\e[0;34m\]\h\[\e[m \e[0;32m\] \w[\!]\$\[\e[m\]  \"" >> ~/.bashrc

# run bash
CMD ["/bin/bash"]

