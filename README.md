# Ansible-core container image

This repository contains the source for building ansible-core container image using the following python versions:

* pypy (slim)
* python (slim)

The image is [tagged](https://github.com/orgs/srl-labs/packages?repo_name=ansible-core) with the python backend/version and a matching ansible-core version, e.g.:

* `ghcr.io/srl-labs/ansible-core/pypy3.10:2.12.0` for pypy3.10 backend and ansible-core 2.12.0
* `ghcr.io/srl-labs/ansible-core/py3.10:2.12.0` for python3.10 backend and ansible-core 2.12.0

Images are built for linux/amd64 and linux/arm64 architectures.

## Build

Automated builds are setup for the repository and the matrix of base images, ansible core version and python version are listed in the [`matrix.yml`](.github/matrix.yml) file. Add additional version to the matrix, push the changes in a branch and wait for tests to pass.

If all good, merge the PR and create a release adding a date as a release name to indicate when it was released.

## Usage

Can be used as a base image for container images with the required plugins/roles or as a standalone container for running ansible playbooks.

```bash
alias ansible-playbook="docker run --rm -it \
  -w /ansible \
  -v $(pwd):/ansible \
  -v ~/.ssh:/root/.ssh \
  -v /etc/hosts:/etc/hosts \
  -e SSH_AUTH_SOCK=/tmp/ssh_agent_socket \
  -v $(echo $SSH_AUTH_SOCK):/tmp/ssh_agent_socket \
  ghcr.io/srl-labs/ansible-core/2.15.9:py3.11 \
  ansible-playbook -i inventory.yml $@"
```
