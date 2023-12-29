FROM ubuntu:22.04

ARG username

ARG DEBIAN_FRONTEND=noninteractive

# Required packages from https://docs.zephyrproject.org/latest/develop/getting_started/index.html
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    git \
    cmake \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    device-tree-compiler \
    wget \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-tk \
    python3-wheel \
    xz-utils \
    file \
    make \
    gcc \
    gcc-multilib \
    g++-multilib \
    libsdl2-dev \
    libmagic1 && \
    apt-get clean

# Install west and other python dependencies
RUN pip3 install --no-cache-dir \
    west \
    -r https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/main/scripts/requirements.txt \
    -r https://raw.githubusercontent.com/zephyrproject-rtos/mcuboot/main/scripts/requirements.txt \
    -r https://raw.githubusercontent.com/nrfconnect/sdk-nrf/main/scripts/requirements.txt

# Get and install Zephyr SDK
RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.4/zephyr-sdk-0.16.4_linux-x86_64_minimal.tar.xz \
    -q -O /tmp/zephyr-sdk.tar.xz && \
    tar xf /tmp/zephyr-sdk.tar.xz -C /opt && \
    /opt/zephyr-sdk-0.16.4/setup.sh -t arm-zephyr-eabi -c && \
    rm -rf /tmp/*

RUN useradd -ms /bin/bash $username
USER $username

WORKDIR workdir

CMD ["/bin/bash"]
