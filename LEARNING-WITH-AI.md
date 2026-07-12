# Learning with AI — use the assistant, keep the skill

An AI assistant can carry you through every lab in this series. It will name the tool, write the
command, and explain the output — and if you let it, it will do all of that while you learn almost
nothing. Nobody is grading these labs. The only thing at stake is whether the skill ends up in **your
head** or in a chat log you'll never reread.

So we're not going to tell you not to use AI. Working security professionals use it every day. We're
going to tell you how to use it so that *you* get stronger, not just your transcript. Two ideas do
most of the work: treat each lab as a **kata**, and treat the AI as a **thinking partner you
interrogate**, not an oracle you obey.

## Why this matters more in security than anywhere else

**Pasting commands you don't understand is the attack vector.** "Curl this and pipe it to bash" is
how real machines get compromised. A professional who runs whatever a chat window suggests has the
exact habit these labs exist to train out of you. Interrogating every command before you run it isn't
just good study technique here — it *is* the discipline.

And one day there is no chat window: an incident at 2 a.m., an interview whiteboard, a network that's
air-gapped precisely because it matters. What you can do without the assistant is what you actually
know.

## The kata loop

A kata is a form you repeat until it's in your hands. Do each lab **more than once**, and demote the
AI each time through:

1. **Round 1 — AI as guide.** Full assistance allowed, under the rules below. Get through the lab,
   understand every step, take nothing on faith.
2. **Round 2 — AI as reviewer.** Reset the lab (`down -v`, start fresh) and do it yourself first.
   Only when you're done — or genuinely stuck — ask the AI to critique your approach: what did I
   miss, what would a professional have done differently, what's the faster path?
3. **Round 3 — closed book.** No AI at all. If you stall, *write down where* — that note is the gap
   in your knowledge, and it's gold. Finish with help, then come back and run round 3 again.

You're done with a lab when round 3 is boring. The trap to avoid: replaying round 1 forever and
mistaking the AI's fluency for your own.

## The contract — four rules for round 1

- **Never run a command you can't explain.** If the AI gives you one, your next message is: *"break
  down every flag in that command before I run it."* No exceptions, even for commands that look
  familiar.
- **Ask "why this one?"** What are the alternative tools or approaches, and why did it pick this
  one? (`nmap` vs `masscan`, `chisel` vs `ssh -L`, `grep` vs the tool's own filter.) The comparison
  is usually worth more than the command.
- **Predict before you execute.** Say out loud (or type into the chat) what you expect the output to
  be. When reality differs, that gap is the lesson — chase it before moving on.
- **Ask for the failure modes.** When would this command mislead you? What does it look like when it
  half-works? What would a defender see in the logs when you run it?

## Prompts that work

Steal these verbatim:

> I'm working through a hands-on security lab on <topic>. Act as a tutor, not a solver: don't give
> me commands. Ask me questions until I propose a next step myself, then critique my proposal.

> Before I run this command, explain every flag, tell me what output you expect, and name one way
> the output could mislead me: `<command>`

> Here's what I did and what happened: <paste>. Don't tell me the fix yet — ask me three questions
> that would help me figure it out myself.

> (Round 2) I finished the lab this way: <your steps>. Review it like a senior colleague — what did
> I miss, what was wasteful, and what would you have done instead?

And the prompt that wastes the lab, so you recognise it in your own typing: *"give me the commands
to finish phase 2."* You'll get them. They'll work. You'll have practised copy-paste.

## The AI will be wrong — treat that as a feature

Assistants confidently invent tool flags, mix up versions, misremember default ports and log
formats, and describe output that the tool has never printed. In most subjects that's a nuisance; in
this lab it's a free lesson, because **the environment is the ground truth**. The lab is running on
your machine — when the AI and the terminal disagree, the terminal wins, and finding out *why* they
disagreed teaches more than either alone.

This is the same muscle as the series' audit motto — *substantiate, don't assume*. Verify what the
assistant tells you the way you'd verify what an auditee tells you: against evidence.

## One habit to take away

If you keep a single thing from this page, keep the first rule of the contract. **Nothing runs on
your machine that you can't explain.** It will slow you down for a week and make you dangerous for a
career.
