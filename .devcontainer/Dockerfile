# [Choice] Debian OS version (use bookworm, or bullseye on local arm64/Apple Silicon): 3.2-bookworm, 3.2-bullseye, 3.2-buster
ARG VARIANT=bookworm
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

## set current user to `root`
USER root

## define build arguments
ARG USERNAME=vscode
ARG VSC_SERVER_PATH="/home/${USERNAME}/.vscode-server"

## ################################################################ ##
## Directive 1: define a Docker VOLUME for `~/.vscode-server`
VOLUME [ "${VSC_SERVER_PATH}" ]

## Directive 2: create directory and set ownership to non-root user
RUN set -eux; \
  mkdir -p "${VSC_SERVER_PATH}" && \
  chown ${USERNAME}:${USERNAME} "${VSC_SERVER_PATH}"
## ################################################################ ##

## set current user to non-root user
USER "${USERNAME}"

# ENV Variables required by Jekyll
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    TZ=Etc/UTC \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US
