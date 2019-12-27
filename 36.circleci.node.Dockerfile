FROM circleci/python:3.6-node

USER root

RUN apt-get update && \
  apt-get install -y --no-install-recommends openjdk-11-jdk-headless && \
  # mecab-ko
  cd /tmp && \
  curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz && \
  tar zxfv mecab-0.996-ko-0.9.2.tar.gz && \
  cd mecab-0.996-ko-0.9.2 && ./configure && make && make check && make install && \
  ldconfig && \
  # mecab-ko-dic
  curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz && \
  tar -zxvf mecab-ko-dic-2.1.1-20180720.tar.gz && \
  cd mecab-ko-dic-2.1.1-20180720 && \
  ./autogen.sh && ./configure && make && make install && \
  sh -c 'echo "dicdir=/usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc' && \
  cd / && \
  rm -rf /var/lib/apt/lists/* /tmp/*

USER circleci

