# Optional custom toolbox image for __LAB_TITLE__.
#
# The starter compose uses the shared ghcr.io/michael-borck/ethical-base image, so
# you don't need this to begin. When you want your own tools, build on this, switch
# the attacker image in docker-compose.yml to
#   ghcr.io/__OWNER__/__LAB_SLUG__-base:latest
# and let .github/workflows/build.yml publish it (multi-arch) on push.
FROM debian:stable-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash nmap curl wget netcat-openbsd iproute2 iputils-ping \
    openssh-client ca-certificates vim \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /root
CMD ["/bin/bash"]
