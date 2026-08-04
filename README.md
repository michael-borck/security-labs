# Security Labs — the Assume-Breach Series

The umbrella for a family of self-contained, Docker-based security labs. Each lab runs on a laptop,
hides Docker and logs you straight into a real interactive shell, and teaches one part of the attack lifecycle. This repo is
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
| Govern / audit | [security-audit-lab](https://github.com/michael-borck/security-audit-lab) | Audit & controls (not Docker — a web + interview simulation) |

## Foundations — the network underneath

The lifecycle labs assume a working network: routes that hold, DNS that resolves, firewalls with rules
already in them. These two build that layer, so *"the scan never reached the host"* becomes something
you can reason about instead of a mystery.

| | Repo | Stance |
|---|-----|--------|
| Run the network | [enterprise-network-lab](https://github.com/michael-borck/enterprise-network-lab) | Docker — four-site WAN with real FRR/OSPF, dnsmasq, nftables and a Suricata sensor |
| Reason about the network | [netsim](https://github.com/michael-borck/netsim) | Browser — a topology simulator that takes real Linux syntax (not Docker, no install) |

## The books, the game & the toys

Two companion books — **[*Assume Breach*](https://michael-borck.github.io/assume-breach/)** (the
defender's mindset) and **[*Substantiate, Don't Assume*](https://michael-borck.github.io/substantiate-dont-assume/)**
(security audit & controls) — and the **[*Incident Zero* game](https://incidentzero.retroverse.studio/)**
(the whole lifecycle as cooperative play).

And **[security-toys](https://michael-borck.github.io/security-toys/)** — single-page browser toys,
each built to break one specific misconception (how long a password *really* lasts; why no alert
threshold catches everything). No Docker, no install, no network: they're the ten minutes before a
lab, not the lab.

## For instructors

Learner walkthroughs stay in the public labs. Answer keys, marking rubrics and facilitator guides
deliberately do not — they live in **`security-labs-staff`**, a private, invite-only companion repo, so
a student who finds this page can't find the solutions. It holds per-module facilitator guides,
assignment briefs and rubrics, the full lateral-movement pivot solution, the audit lab's planted-gap
map and answer key, and the IT brief on running these labs on managed machines. No runnable lab lives
there — it's assessor material only.

Teaching this material? Request access by [opening an issue](https://github.com/michael-borck/security-labs/issues).

## What's in this repo

- **[`LEARNING-WITH-AI.md`](LEARNING-WITH-AI.md)** — how to do these labs *with* an AI assistant and
  still end up with the skill: the kata loop, and the rules for using AI as a thinking partner.
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
