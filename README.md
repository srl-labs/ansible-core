# Ansible-core container image

This repository contains the source for building ansible-core container image using the following python versions:

* pypy (slim)
* python (slim)

The image is tagged with the python backend/version and a matching ansible-core version, e.g.:

* `ghcr.io/srl-labs/ansible-core/pypy3.10:2.12.0` for pypy3.10 backend and ansible-core 2.12.0
* `ghcr.io/srl-labs/ansible-core/py3.10:2.12.0` for python3.10 backend and ansible-core 2.12.0

Images are built for linux/amd64 and linux/arm64 architectures.
