# Why Docker — and when to reach for something else

These labs run in Docker. That's a deliberate choice with real trade-offs, not a claim that
containers are always best. This page is the honest version: what Docker buys us, where it genuinely
falls short, and which other approach to use when it does.

## Why we chose Docker

- **Runs on any laptop.** Containers share the host kernel, so they start in seconds and use megabytes,
  not gigabytes. A whole multi-host lab fits where a single VM wouldn't.
- **One command, right architecture.** Our images are published multi-arch (amd64 **and** arm64), so
  `docker compose pull` gets a native image on Apple Silicon and Intel/Windows alike — no "you can't run
  this x86 VM on your M-series Mac" wall.
- **Reproducible and disposable.** Everyone gets the identical environment; `down -v` wipes it and the
  next `up` is clean. No drifting VM snapshots.
- **Networks as code.** A `docker-compose.yml` describes hosts and segments in a few lines — easy to
  read, diff, and hand to the next person.
- **Trivial distribution.** No multi-gigabyte VM image to download; pull small layers from a registry.

For *teaching security concepts* — enumeration, credential reuse, firewalls, packet analysis, evidence
analysis — that combination is hard to beat.

## Where Docker falls short

Containers share the host's kernel and can't see its hardware. That single fact explains most of the
limits below. When a lab needs one of these, the honest answer is "use a different tool" — and we say so.

- **Physical evidence acquisition.** You can't image a real USB stick or disk *from inside a container*.
  Docker Desktop on macOS/Windows runs the engine in a lightweight VM that doesn't see host USB block
  devices at all; even on Linux, `--device=/dev/sdb --privileged` is host-specific and not portable. So
  our forensics lab is an **analysis** environment (it works on evidence images that were *already*
  acquired), not an **acquisition** one. To actually acquire: a hardware/software **write-blocker** plus
  `dd`/`Guymager`/`FTK Imager` on real hardware.
- **Kernel-level work.** Kernel exploits, loadable-kernel-module rootkits, some privilege-escalation and
  container-escape topics — a container shares the host kernel, so these either don't work or aren't safe
  to run. A VM has its own kernel and is the right tool.
- **Windows targets & Active Directory.** Windows containers are heavy and limited; realistic Windows
  victims, AD domains, and most Windows malware work belong in VMs.
- **Wireless, Bluetooth, and hardware.** Monitor-mode/packet injection, RFID/NFC, USB HID, JTAG/UART —
  all need real radios and real ports. Containers can't provide them portably.
- **Live malware detonation.** Shared-kernel isolation is weaker than a hypervisor's. Detonate real
  malware in a disposable VM on an isolated network, not a container.
- **Nested virtualization / hypervisor labs.** Running VMs *inside* the environment isn't a container job.
- **GUI realism.** We ship browser desktops (noVNC/webtop) where a GUI earns its keep, but it's clunkier
  than a real VM desktop, and heavy graphical tools suffer.
- **"Feels like a real machine."** A container host is minimal and ephemeral (often no systemd, few
  background services). Great for isolating one concept; less convincing as a full enterprise box.

## The alternatives, and when each wins

| Approach | Best for | Cost of that |
|----------|----------|--------------|
| **Docker containers** (our default) | Concept labs, mixed-hardware cohorts, fast reset, easy distribution | No real kernel, no hardware, weaker isolation |
| **VMs** — VirtualBox / VMware / UTM / Hyper-V | Real/other OS, Windows & AD, kernel work, malware, snapshots | Heavy (GBs), slow to distribute, arch-locked (x86 VM won't run on ARM) |
| **Bare metal / air-gapped rig** | Physical forensics acquisition, wireless/hardware, safest malware work | Expensive, not portable, setup-heavy, one user at a time |
| **VPS / cloud range** | Always-on, remote or team access, more horsepower, persistent CTF infra | Ongoing cost; exposure/legal care; you manage teardown |
| **Managed platforms** (Hack The Box, TryHackMe, …) | Zero setup, gamified, curated progression | Subscription; less control; not your own scenarios |

## A quick decision guide

- Teaching a **concept** to a class on their own laptops → **Docker** (these labs).
- Need a **real OS, Windows/AD, kernel internals, or snapshots** → **a VM**.
- Need to **acquire physical evidence, do wireless, or detonate real malware** → **bare metal / air-gapped**.
- Need it **always-on or shared across a team** → **a VPS / cloud range**.
- Want **curated practice with no setup** → a **managed platform** (see
  [FURTHER-PRACTICE.md](FURTHER-PRACTICE.md)).

Docker is the right default for what these labs teach. Knowing its edges — and what to pick up when you
hit one — is part of the lesson.
