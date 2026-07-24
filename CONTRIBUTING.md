# Contributing

Thanks for helping grow the series. Contributions mostly need one thing beyond the usual: an
understanding of **how these labs are built** — how we use Docker and a few scripts to simulate a
security environment. Read **[`ARCHITECTURE.md`](ARCHITECTURE.md)** first; it's short and it's the map.

## What you'll need

- Docker Desktop (or Docker Engine) able to run `docker compose`.
- Comfort with a shell, `docker`/`docker compose`, and basic Dockerfiles.
- The mental model in `ARCHITECTURE.md`: containers = hosts, networks = segments, planted files =
  scenario, the console hides Docker and drops the learner into a real interactive shell.

## Two ways to contribute

### 1. Add a module (or fix one) in an existing lab

Best when your idea fits a lab that already exists.

1. Add or edit the service(s) in that lab's `docker-compose.yml` (give new hosts static IPs).
2. Write or update the phased section in `LAB-GUIDE.md` in the house voice (Scenario → phases →
   cleanup). No worksheet language, no marks.
3. If you added a custom image, add it to the lab's GHCR workflow matrix so it publishes multi-arch.
4. Regenerate the network map: `python3 tools/gen-netmap.py`.
5. Update the landing page (`docs/index.html`) if you added a learner-facing target.

### 2. Create a new lab

Best when the scenario is a new topic. From this repo:

```bash
./create-lab.sh my-new-lab "My New Lab"
```

It scaffolds `../my-new-lab/` in the house style (console, landing page with the Series strip, phased
guide, GHCR workflow, Makefile). Then:

1. Model the environment in `docker-compose.yml` — the hosts and the segment(s).
2. Bake or generate the scenario (weak creds, evidence, planted loot).
3. Write `LAB-GUIDE.md`.
4. Add the new lab to the Series strip in **all** the labs and to the hub landing page here.

## Conventions (please keep these)

- **Unit-agnostic.** No course codes, week numbers, "worksheet/assignment/semester", or institution
  names — in content *or* filenames.
- **Real shell, honest.** Hide Docker and log the student into a real shell running the genuine tools;
  the console and landing page describe what the lab actually does.
- **Multi-arch.** Anything you publish must build for `amd64` and `arm64`. Prefer multi-arch third-party
  images; pin `platform:` only for unavoidable `amd64`-only ones, and note it.
- **Pull, don't build** by default; keep the `docker-compose.build.yml` overlay working for offline use.
- **No answers in public repos.** Learner walkthroughs are fine; rubrics, model answers, and assessment
  material go to the private `security-labs-staff` repo.
- **MIT licensed.**

## Testing before a PR

```bash
docker compose config >/dev/null      # compose is valid
docker compose up -d && docker compose ps   # it comes up
# walk your own guide end-to-end from the attacker box
python3 tools/gen-netmap.py            # map matches reality
docker compose down -v                 # clean teardown
```

If you can run the lab from a fresh `./start.sh` on a machine that has never seen it, and the guide's
steps work as written, it's ready.
