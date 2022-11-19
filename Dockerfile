# syntax=docker/dockerfile:1
FROM ubuntu:18.04
RUN apt-get -y update

# Install base utilities
RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install libglib2.0-0 && \
    apt-get clean && \
    apt-get -y install git && \
    rm -rf /var/lib/apt/lists/*

#RUN docker rmi $(docker images | grep 'sd-ui:debug')

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH




WORKDIR /app
COPY . .

ENTRYPOINT ["scripts/start.sh"]
EXPOSE 9000