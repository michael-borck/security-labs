# __LAB_TITLE__

A self-contained, Docker-based security lab. Part of the
[Assume-Breach series](https://michael-borck.github.io/security-labs/).

## Quick start

1. Install Docker Desktop.
2. Run it:

   ```bash
   ./start.sh          # macOS/Linux (or double-click start.command on macOS)
   ```

   On Windows, run `start.bat` from Git Bash or WSL2.

That launches an immersive console — the machines power on and you drive the lab with plain commands
(`connect`, `open`, `guide`). No `docker` typing required. Power users can use `make run` /
`docker compose` directly.

## What's here

- `docker-compose.yml` — the environment (an attacker box + a target on one network, to start).
- `scripts/lab-console` — the immersive console.
- `LAB-GUIDE.md` — the walkthrough.
- `docs/index.html` — the landing page (GitHub Pages).
- `base.Dockerfile` + `.github/workflows/build.yml` — optional custom toolbox image, published
  multi-arch to GHCR.

## Build this out

This is a scaffold. Next steps:

1. Model your scenario in `docker-compose.yml` (hosts, network segments, planted files).
2. Write `LAB-GUIDE.md`.
3. Update `docs/index.html` (hero + the Series strip), then `python3 tools/gen-netmap.py`.

See the series [architecture guide](https://github.com/michael-borck/security-labs/blob/main/ARCHITECTURE.md)
for how each piece fits together.

## Licence

MIT.
