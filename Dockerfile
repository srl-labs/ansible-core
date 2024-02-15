ARG BASE_IMAGE=pypy:3.10-slim

FROM ${BASE_IMAGE}

ARG ANSIBLE_CORE_VERSION=2.15.4

RUN apt update && apt install -y openssh-client

RUN pip install --no-cache-dir ansible-core==${ANSIBLE_CORE_VERSION}

CMD [ "bash" ]