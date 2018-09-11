FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
RUN apt-get update && apt-get install -y --no-install-recommends \
curl \
ca-certificates \
python \
&& \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
python get-pip.py && \
rm get-pip.py

COPY fetch_and_run.sh /usr/local/bin/

# -- Install Pipenv:
RUN pip install pipenv --upgrade
WORKDIR /home

# -- Adding Pipfiles
COPY Pipfile Pipfile
RUN pipenv install
ENV LD_LIBRARY_PATH /usr/local/cuda8.0/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
ENV CUDA_HOME /usr/local/cuda-8.0
ENTRYPOINT ["/usr/local/bin/fetch_and_run.sh"]
