FROM jupyter/base-notebook

LABEL maintainer="Mads Jensen <mads@cfin.au.dk>"

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone git@github.com:MadsJensen/pyfin_pandas_intro.git \
    /home/jovyan/Tutorial && \
    mkdir /home/jovyan/Tutorial/files

WORKDIR /home/jovyan/Tutorial
ENTRYPOINT [ "/bin/bash", "-c"]
RUN conda env create -f -p2 environment.yaml && \
    conda clean -a -y
ENV PATH /opt/conda/envs/p2/bin:$PATH
ENV CONDA_DEFAULT_ENV p2
ENV CONDA_PREFIX /opt/conda/envs/p2

RUN pip install mne nibabel nitime pysurfer matplotlib jupyterlab nilearn pandas && \
    /home/jovyan/Tutorial && \
    mkdir /home/jovyan/Tutorial/output && \
    mkdir /home/jovyan/Tutorial/Data

RUN chown -R jovyan: /home/jovyan/Tutorial
USER jovyan
WORKDIR /home/jovyan/Tutorial
