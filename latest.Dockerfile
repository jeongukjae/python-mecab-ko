FROM circleci/python:latest

# Install KoNLPy dependencies and MeCab
# http://konlpy.org/en/latest/install/
RUN sudo apt-get update && \
    sudo apt-get install -y g++ openjdk-8-jdk python-dev python3-dev curl && \
    # mecab-ko
    cd /tmp && \
    curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz && \
    tar zxfv mecab-0.996-ko-0.9.2.tar.gz && \
    cd mecab-0.996-ko-0.9.2 && ./configure && make && make check && sudo make install && \
    sudo ldconfig && \
    # mecab-ko-dic
    curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz && \
    tar -zxvf mecab-ko-dic-2.1.1-20180720.tar.gz && \
    cd mecab-ko-dic-2.1.1-20180720 && \
    ./autogen.sh && ./configure && make && sudo make install && \
    sudo sh -c 'echo "dicdir=/usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc'
