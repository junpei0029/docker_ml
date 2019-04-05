FROM ubuntu:18.04

RUN mkdir /v

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
build-essential \
curl \
git \
graphviz \
libgl1-mesa-dev \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
&& apt-get install -y software-properties-common \
&& add-apt-repository ppa:neovim-ppa/stable \
&& apt-get install -y --no-install-recommends \
neovim

RUN curl -qsSLkO \
https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-`uname -p`.sh \
&& bash Miniconda3-latest-Linux-`uname -p`.sh -b \
&& rm Miniconda3-latest-Linux-`uname -p`.sh

ENV PATH=/root/miniconda3/bin:$PATH

RUN conda install -y \
h5py \
pandas \
keras \
tensorflow \
scikit-learn \
pydot \
jupyter \
matplotlib \
seaborn \
py-xgboost \
lightgbm \
dask \
opencv \
&& conda clean --yes --tarballs --packages --source-cache

VOLUME /v
WORKDIR /v
EXPOSE 8888
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --NotebookApp.allow_origin='*'


