# Security Labs — the Assume-Breach Series

The umbrella for a family of self-contained, Docker-based security labs. Each lab runs on a laptop,
hides Docker behind an immersive console, and teaches one part of the attack lifecycle. This repo is
the **front door, the shared architecture, and the scaffold** — the labs themselves live in their own
repos.

**→ [The series landing page](https://michael-borck.github.io/security-labs/)**

## The series

| | Lab | Stance |
|---|-----|--------|
| Break in | [ethical-hacking-docker-labs](https://github.com/michael-borck/ethical-hacking-docker-labs) | Offensive — initial access |
| Move through | [cybersecurity-lab-lateral-movement](https://github.com/michael-borck/cybersecurity-lab-lateral-movement) | Offensive — post-exploitation |
| Assume compromise | [assume-breach-labs](https://github.com/michael-borck/assume-breach-labs) | Defensive |
| Investigate | [forensics-docker-lab](https://github.com/michael-borck/forensics-docker-lab) | Post-breach |

Plus the companion **[*Assume Breach* book](https://michael-borck.github.io/assume-breach/)** (the mindset)
and the **[*Incident Zero* game](https://incidentzero.retroverse.studio/)** (the whole lifecycle as
cooperative play).

Answer keys and facilitator guides are **not** public — they live in a private companion repo
(`security-labs-staff`). Learner walkthroughs stay in the public labs.

## What's in this repo

- **[`WHY-DOCKER.md`](WHY-DOCKER.md)** — why these labs are containers, where Docker falls short (physical
  forensics, kernel work, malware), and which approach — VM, bare metal, VPS — to use instead.
- **[`FURTHER-PRACTICE.md`](FURTHER-PRACTICE.md)** — the wider ecosystem: VulnHub, Hack The Box,
  PortSwigger, OverTheWire, DFIR datasets and more, mapped to these labs.
- **[`ARCHITECTURE.md`](ARCHITECTURE.md)** — how a lab is built: how we use Docker + a few scripts to
  simulate a security environment. Read this before contributing.
- **[`CONTRIBUTING.md`](CONTRIBUTING.md)** — the two contribution paths (add a module / new lab).
- **[`create-lab.sh`](create-lab.sh)** + **[`template/`](template/)** — scaffold a new lab in the house style.
- **[`docs/`](docs/)** — the series landing page (GitHub Pages).

## Create a new lab

```bash
./create-lab.sh my-new-lab "My New Lab"
```

This copies `template/` into a sibling `../my-new-lab/` directory, substitutes the name throughout, and
prints next steps. The scaffold gives you a working console, a landing page (with the Series strip
pre-wired), a phased `LAB-GUIDE.md`, a multi-arch GHCR workflow, and a `Makefile` — so you start on the
security scenario, not the plumbing. See [`ARCHITECTURE.md`](ARCHITECTURE.md) for what each piece does.

## Licence

MIT. Unit-agnostic teaching material — no institution or course branding.
