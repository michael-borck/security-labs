# Anatomy of a lab

How these labs work under the hood — how we use Docker and a few shell scripts to simulate a security
environment, and the standard skeleton every lab in the series shares. Read this before contributing.

The per-lab specifics (which containers, which network, which evidence) live in each lab's own README.
This document is only about the **shared** structure.

---

## 1. The idea

A security lab needs a small network of machines you can attack, defend, or investigate. Traditionally
that meant VMs — heavy, slow to distribute, easy to drift. We build the same environment out of
**containers on a Docker network** instead:

- **A container is a host.** A target, an attacker box, a server, a victim workstation.
- **A Docker network is a network segment.** Put hosts on the same network and they can reach each
  other; split them across networks (with one dual-homed host) and you get real segmentation to pivot
  across.
- **Planted files are the scenario.** Weak credentials, reused SSH keys, a `.bash_history`, deleted-but-
  recoverable evidence — baked into the images at build time.
- **A few scripts hide the plumbing** so the learner drives the lab with plain verbs, not `docker`.

Two audiences, one repo: a **learner** who just wants to log in and start, and a **power user** who can
drop to raw `docker` commands. The console serves the first without blocking the second.

## 2. Design principles

1. **Self-contained and offline-first.** No external web dependencies a lab can't survive losing.
   Targets, evidence, and tools live inside the compose network or are fetched by an explicit script.
2. **Immersive by default, Docker hidden.** The learner runs `./start.sh`, "logs in", and uses verbs
   like `connect` / `open` / `guide`. They never need to know it's Docker.
3. **Pull, don't build.** Images are published multi-arch to GHCR, so the default path is a fast pull.
   Building locally is an offline/dev fallback, not the norm.
4. **Multi-arch or bust.** Every image we own is built for `amd64` **and** `arm64`, so it runs natively
   on Apple Silicon and Intel/Windows alike.
5. **Unit-agnostic.** No course codes, week numbers, "worksheet", or institution branding — anywhere.
   These are standalone labs anyone can pick up.
6. **Honest.** The landing page describes what the lab actually does. If it says "pivot", the network is
   really segmented.

## 3. The standard skeleton

```
<lab>/
├── start.sh / start.command / start.bat   # learner entry points → scripts/lab-console
├── scripts/lab-console                     # the immersive REPL that hides Docker
├── docker-compose.yml                      # the environment: hosts (services) + networks (segments)
├── Makefile                                # run / stop / status / build-base — the power-user surface
├── LAB-GUIDE.md                            # the phased walkthrough (house voice)
├── README.md                               # lab-specific overview + this-lab's technical notes
├── base.Dockerfile (or an image dir)       # the shared toolbox image, if the lab builds one
├── tools/gen-netmap.py                     # regenerates the network diagram from compose
├── docs/
│   ├── index.html                          # GitHub Pages landing page + the Series strip
│   ├── .nojekyll
│   └── diagrams/*.svg                       # generated network maps
└── .github/workflows/build*.yml            # build & publish images to GHCR (multi-arch)
```

Not every lab has every file (a CLI-only lab has no VNC service; a single-scenario lab has one
`LAB-GUIDE.md`, a multi-module lab has several). But the shape is consistent enough that the scaffold
can stamp it out.

## 4. The immersive console

`start.sh` (and the macOS `.command` / Windows `.bat` wrappers) do one thing: launch
`scripts/lab-console`. The console:

- checks Docker is installed and running, with a friendly message if not;
- "logs the learner in" (asks a name, prints a themed banner);
- brings the environment up **behind a spinner** — `pull` the images, fall back to `build` only if the
  pull fails, then `up -d`;
- drops the learner into a `lab>` prompt with verbs: `connect` (shell into the attacker box), `open`
  (a browser target), `guide` (print the lab guide), `status`, `stop`.

The console is the product surface. Everything it does is achievable with raw `docker` too — it just
removes the need.

## 5. Images and the GHCR pipeline

- Custom images are defined by a `base.Dockerfile` or a per-image directory, and published to
  `ghcr.io/<owner>/<image>` by a GitHub Actions workflow.
- **The workflow builds `linux/amd64,linux/arm64`** with QEMU + Buildx and pushes a multi-arch manifest,
  so `docker compose pull` auto-selects the right architecture. This is what makes Apple Silicon native.
- **Set each package to Public once** after the first publish (a GHCR UI setting), or unauthenticated
  pulls fail.
- `docker-compose.yml` references the GHCR image; a `docker-compose.build.yml` overlay lets a developer
  build locally instead: `docker compose -f docker-compose.yml -f docker-compose.build.yml build`.

### Third-party images and architecture

Building an image does **not** change its architecture — that comes from the base image. If an upstream
image is published `amd64`-only, both pulling it and building `FROM` it give you `amd64` (emulated, slow
on Apple Silicon). So:

- Prefer third-party images that are already multi-arch.
- If an `amd64`-only image has a good multi-arch equivalent, swap it.
- If it doesn't and the tool is lightweight, pin `platform: linux/amd64` (silences the warning; accept
  emulation) and say so in the docs.

## 6. Networks, privileges, and evidence

- **Segments = networks.** One flat network for a simple lab; two or more (with a dual-homed pivot host)
  when the scenario needs real segmentation. Give services static IPs so the guide can reference them.
- **Least privilege, documented.** Most labs need only `cap_add` (e.g. `NET_ADMIN` for raw sockets).
  When a lab genuinely needs more — `privileged` to toggle ASLR, `/dev/fuse` + `SYS_ADMIN` to mount
  evidence images — say why in the README, and provide a fallback for locked-down hosts.
- **Evidence has three honest sources:** *baked* into an image at build time; *generated* by a script
  (so it's reproducible and license-clean); or *downloaded* by an explicit fetch script when licensing
  forbids redistribution. Never pretend generated data is real-world data.

## 7. The landing page and the Series strip

Each lab publishes a themed, theme-aware `docs/index.html` via GitHub Pages — the student front door. It
is a static index (it does not run containers): a hero, module cards, and a **"Series" strip** linking
the four labs + the book + the game, with the current lab marked "you are here". The strip is identical
across the labs (only the "here" card differs), so finding one lab reveals the whole series. A lab that
maps to an *Incident Zero* module also carries a "Going further — Incident Zero" note in its guide.

Cross-map diagrams are generated by `tools/gen-netmap.py`, which reads the topology live from
`docker compose config` so the diagram never drifts from the actual compose file.

## 8. Where the answers live

Public labs ship **learner walkthroughs** (a walkthrough is a feature of a self-teaching lab). Anything
an assessor relies on — rubrics, model answers, exemplars, assignment briefs — lives in the **private**
`security-labs-staff` repo, one folder per lab. Keep public repos free of answer keys and marking
material.

## 9. The house voice

`LAB-GUIDE.md` reads as an immersive, second-person scenario, not a worksheet: **Scenario → phased
objectives → cleanup → "Going further"**. No "submit a report", no marks, no fill-in-the-blank answer
boxes. The story frames the tactics; the tactics teach the concept.
