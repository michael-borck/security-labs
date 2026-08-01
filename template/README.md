# __LAB_TITLE__

A self-contained, Docker-based security lab. Part of the
[Assume-Breach series](https://michael-borck.github.io/security-labs/).

## Quick start

1. Install Docker Desktop.
2. Run it:

   ```bash
   ./start.sh          # macOS/Linux (or double-click start.command on macOS)
   ```

   On Windows, install [Git for Windows](https://git-scm.com/download/win) once, then just
   double-click `start.bat` (no terminal needed — it finds Git Bash or WSL by itself).

That powers the lab up in Docker and logs you straight into a **real workstation shell** — a genuine
command line on the `attacker` box, running the actual tools. Type `labhelp` for the mission and
`netmap` for the network map. No `docker` typing required. Power users can use `make run` /
`docker compose` directly.

## What's here

- `docker-compose.yml` — the environment (an attacker box + a target on one network, to start).
- `base.Dockerfile` + `station/` — the attacker workstation image: real tools, welcome banner,
  `labhelp` / `netmap`, themed prompt.
- `scripts/lab-console` — the launcher (brings the lab up, then logs you into the workstation shell).
- `LAB-GUIDE.md` — the walkthrough.
- `docs/index.html` — the landing page (GitHub Pages).
- `.github/workflows/build.yml` — publishes the workstation image (`base.Dockerfile`) multi-arch to GHCR.

## Build this out

This is a scaffold. Next steps:

1. Model your scenario in `docker-compose.yml` (hosts, network segments, planted files).
2. Write `LAB-GUIDE.md`.
3. Update `docs/index.html` (hero + the Series strip), then `python3 tools/gen-netmap.py`.

See the series [architecture guide](https://github.com/michael-borck/security-labs/blob/main/ARCHITECTURE.md)
for how each piece fits together.

Fill in `SECURITY.md` as you go — it is what stops a reviewer re-reporting your
deliberate choices as findings.

## Adding a service the student opens in a browser

The scaffold publishes no ports, and `labnet` is `internal: true` so nothing can
reach the internet or the network your machine sits on. If your lab needs a web UI,
there are two traps — both verified, neither documented by Docker.

**1. Never publish a port with the short syntax.** `"8080:80"` binds `0.0.0.0`, so
the service is reachable by every device on the network you happen to be on. Always
name the interface:

```yaml
    ports:
      - "${LAB_BIND:-127.0.0.1}:8080:80"
```

**2. `internal: true` silently discards published ports.** A service with `ports:`
on an internal network starts fine, shows no host mapping, warns about nothing, and
is simply unreachable. So a browser-facing service needs its own non-internal
network — keep everything else on `labnet`:

```yaml
services:
  webapp:
    image: your/app:1.2.3          # pin it
    ports:
      - "${LAB_BIND:-127.0.0.1}:8080:80"
    networks: [webnet]             # NOT labnet

networks:
  webnet:                          # no `internal:` — publishing needs the gateway
    driver: bridge
```

**If it is a browser desktop** (LinuxServer `webtop`, `wireshark`, noVNC images),
it serves an unauthenticated desktop **with a terminal in it** unless you set
credentials. Always set them:

```yaml
    environment:
      - CUSTOM_USER=${LAB_GUI_USER:-analyst}
      - PASSWORD=${LAB_GUI_PASSWORD:-labpass}
```

**A third trap, if you add a second segment:** `internal: true` also breaks routing
*between* two lab networks — Docker drops traffic whose source is not in the target
bridge's subnet. A firewall, VPN or pivot lab must leave those networks
non-internal, or it will start cleanly and be quietly useless.

## Licence

MIT.
