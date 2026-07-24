# Workstation image for __LAB_TITLE__ — the box the student is dropped into.
#
# docker-compose.yml builds the 'attacker' service from this file, so a freshly
# scaffolded lab is a real security workstation out of the box: real tools, a
# welcome banner, a themed prompt, and `labhelp` / `netmap` commands. Add the
# tools your scenario needs below. On push, .github/workflows/build.yml also
# publishes this image (multi-arch) to ghcr.io/__OWNER__/__LAB_SLUG__-base:latest
# so learners pull a native image instead of building it every time.
FROM debian:stable-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash nmap curl wget netcat-openbsd iproute2 iputils-ping \
    openssh-client ca-certificates vim \
    && rm -rf /var/lib/apt/lists/*

# Security-workstation feel: a welcome banner (MOTD), a `labhelp` quick-reference,
# a `netmap` network diagram, and a themed prompt on every interactive login. This
# is what makes dropping into the container feel like logging into a dedicated
# machine instead of a bare shell — see scripts/lab-console (SHELL_HOST + the
# shell-mode hand-off). Rewrite station/motd + station/labhelp for your scenario.
#
# The banner/prompt snippet is installed for BOTH shell types: /etc/profile.d for
# login shells, and appended to /etc/bash.bashrc for the `docker compose exec bash`
# home shell. The snippet is $--guarded, so a non-interactive `sh -lc 'cmd'` stays
# clean (no banner spam in scripts or CI).
#
# exFAT / external-drive build contexts hand COPY its files as mode 0700, which
# COPY preserves — so set explicit modes: 644 for data + the profile snippet, 755
# for the runnable commands. (Build with DOCKER_BUILDKIT=0 if '._' sidecars trip
# the builder on an external drive.)
COPY station/motd /etc/motd-lab
COPY station/labhelp /usr/local/bin/labhelp
COPY station/netmap /usr/local/bin/netmap
COPY station/lab-bashrc /etc/profile.d/00-lab-workstation.sh
RUN chmod 644 /etc/motd-lab /etc/profile.d/00-lab-workstation.sh \
    && chmod 755 /usr/local/bin/labhelp /usr/local/bin/netmap \
    && cat /etc/profile.d/00-lab-workstation.sh >> /etc/bash.bashrc

WORKDIR /root
CMD ["sleep", "infinity"]
