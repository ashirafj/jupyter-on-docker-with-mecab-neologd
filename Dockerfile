FROM python:3.9.7-buster

WORKDIR /work

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -q -y install sudo mecab libmecab-dev mecab-ipadic-utf8 git curl make xz-utils

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
    ln -s /etc/mecabrc /usr/local/etc/mecabrc && \
    echo dicdir = `mecab-config --dicdir`"/mecab-ipadic-neologd">/etc/mecabrc

COPY requirements_jupyter.txt .
COPY requirements.txt .
RUN pip install -U pip && \
    pip install --no-cache-dir -r requirements_jupyter.txt && \
    pip install --no-cache-dir -r requirements.txt
