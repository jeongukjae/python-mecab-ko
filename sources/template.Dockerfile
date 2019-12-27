FROM {{ base_image }}
{% if 'circleci' in base_image %}
USER root
{% endif %}{% if 'slim' in base_image %}
RUN apt-get -qq update && \
  # slim variants dont have man page
  if [ ! -d /usr/share/man/man1 ]; then \
  mkdir -p /usr/share/man/man1; \
  fi; \
  apt-get install --no-install-recommends -y build-essential autotools-dev automake g++ openjdk-11-jdk-headless python3-dev git curl && \{% else %}
RUN apt-get update && \
  apt-get install -y --no-install-recommends openjdk-11-jdk-headless && \{% endif %}
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
  rm -rf /var/lib/apt/lists/* /tmp/*{% if 'slim' in base_image %} && \
  apt-get purge -y curl{% endif %}
{% if 'circleci' in base_image %}
USER circleci
{% endif %}
