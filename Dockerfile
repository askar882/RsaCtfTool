FROM sagemath/sagemath:latest
USER root
ENV HOME=/root
RUN sed -i 's/\w*\.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
RUN apt update && \
    apt install -y git wget build-essential libbz2-dev libffi-dev libssl-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev libgdbm-dev uuid-dev libgmp-dev libmpfr-dev libmpc-dev
WORKDIR /opt
RUN wget https://mirrors.huaweicloud.com/python/3.9.0/Python-3.9.0.tgz && \
    tar zxf Python-3.9.0.tgz && \
    cd Python-3.9.0 && \
    ./configure && \
    make && \
    make install
RUN git clone https://github.com.cnpmjs.org/askar882/RsaCtfTool.git
WORKDIR /opt/RsaCtfTool
RUN python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple -U pip && \
    pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple && \
    pip3 install -r "requirements.txt" && \
    pip3 install -r "optional-requirements.txt"
WORKDIR /data
ENTRYPOINT ["/opt/RsaCtfTool/RsaCtfTool.py"]
