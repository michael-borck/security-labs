# __LAB_TITLE__ — Lab Guide

> Replace this stub with your scenario. Keep the house voice: immersive, second-person,
> concept-first. No "submit a report", no marks, no fill-in-the-blank answer boxes.
> Keep the "Using an AI assistant?" callout below — it's standard across the series.

> **Using an AI assistant?** Make it a thinking partner, not an autopilot — and never run a command you
> can't explain. The series guide **[Learning with AI](https://github.com/michael-borck/security-labs/blob/main/LEARNING-WITH-AI.md)**
> shows how, including how to repeat each lab until you don't need the assistant at all.

## Scenario

Set the scene in two or three sentences. Who is the learner? What's the situation? What are they
trying to achieve? Make it concrete enough to care about.

## Before you start

```bash
./start.sh        # or: make run
```

This brings the environment up and logs you **straight into a real shell** on the `attacker`
workstation — no menu, no `lab>` prompt. You're at a genuine command line with the lab's tools
already installed. Type `labhelp` for the mission, `netmap` for the network map. When you're done,
`exit` leaves the shell (the lab keeps running; `make stop` to halt it).

## Phase 1 — <name the first objective>

What the learner does, and the concept it teaches. Show the commands they'd run and what a good result
looks like — but let them do the thinking.

```bash
# example
nmap -sn 172.30.0.0/24
```

## Phase 2 — <the next objective>

Build on Phase 1. Each phase should move the story forward and introduce one idea.

## Cleanup

```bash
make down        # stops and removes everything, volumes included
```

## Going further — Incident Zero

If this lab maps to an *Incident Zero* module, connect the tactical skill here to the strategic module
there in one sentence. ([Incident Zero](https://incidentzero.retroverse.studio/) — free, print-and-play.)
