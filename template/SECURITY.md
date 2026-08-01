# Security Policy — __LAB_TITLE__

> **Template note (delete this block once filled in).** Every lab in this series
> ships one of these. It has two jobs: tell a reader which alarming-looking things
> are deliberate, so scanners and reviewers stop re-reporting them; and state
> plainly what the lab does *not* protect against. Fill in the bracketed parts and
> delete anything that does not apply.

## What this repository is

Teaching material. It ships containers that are **deliberately vulnerable and
deliberately over-privileged** — that is the curriculum, not an oversight.

Run it on a machine you control. Do not deploy it on anything reachable from a
network you do not own.

## Reporting a vulnerability

Open an issue at <https://github.com/__OWNER__/__LAB_SLUG__/issues>.

Please report:

- Anything that lets a lab container reach the **host** or the host's network when
  it should not.
- Anything that exposes a lab service **beyond `localhost`** by default.
- Supply-chain problems: unpinned or compromised images, workflow permissions.

Please do **not** report the items in the next section — they are the exercises.

## Deliberate by design

[List anything here that will look like a finding and is not. For example:]

- **Raised capabilities.** `NET_ADMIN` on the attacker box, needed for [reason].
  `NET_RAW` / `user: root` if the lab runs raw-socket tools such as nmap SYN scans.
- **Weak or committed credentials.** [Which files, and why they are weak on purpose.]
- **Vulnerable applications.** [Which, and pinned to which version.]

## Hardening that is in place

So the above is not mistaken for "nothing was considered".

- **Nothing is reachable from outside the host.** Any published port binds
  `127.0.0.1`, not `0.0.0.0`. Compose's short syntax (`"8080:80"`) binds every
  interface, which would expose the lab to the whole network.
- **Containers have no route off their own network.** `labnet` is `internal: true`
  — no NAT gateway, so no internet and no path onto the network the host sits on.
- **External images are pinned**, so a lab behaves the same next year as this year.
- **Browser-based labs require a login.** [If this lab serves a web desktop —
  LinuxServer images serve them *unauthenticated* unless `CUSTOM_USER` and
  `PASSWORD` are set. Set them, and let people override via `.env`.]

## Known limitations

State these rather than let someone discover them.

1. **Anyone who can run containers on a machine can act as root on it.** A container
   runtime creates containers as root and mounts host paths on request, so
   permission to use it is effectively administrative access — whatever the user's
   own account allows. This is documented, intended runtime behaviour, not
   something this repository introduces or can fix. On shared or managed machines,
   either accept it, constrain the runtime's file sharing and registries, reimage
   between sessions, or use **rootless Podman**, which does not carry root
   equivalence. Set `CONTAINER_ENGINE=podman` to run this lab under it.

2. [Anything this lab cannot isolate, and why. Two constraints come up repeatedly,
   both verified and neither documented by Docker:
   `internal: true` **silently discards published ports**, so a browser-facing
   service cannot be isolated and reachable at once; and it **breaks routing
   between two lab networks**, so any firewall/VPN/pivot lab must leave those
   networks non-internal.]
