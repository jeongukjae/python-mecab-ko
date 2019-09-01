FROM circleci/python:latest

RUN apt-get update && \
  apt-get install --no-install-recommends -y openjdk-11-jdk-headless && \
  curl -s https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh | bash && \
  rm -rf /var/lib/apt/lists/*
