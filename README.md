# Never Ask Why

A skill for **Claude Code** and **OpenAI Codex** that makes the agent execute your instruction immediately: no "why do you want this?", no plan discussion, no alternatives, no long recap. Saves tokens, saves time.

## Install

### Claude Code

```bash
git clone https://github.com/belimbingwuluh78-maker/never-ask-why.git
cp -r never-ask-why/skills/never-ask-why ~/.claude/skills/
```

Windows (PowerShell):

```powershell
git clone https://github.com/belimbingwuluh78-maker/never-ask-why.git
Copy-Item -Recurse never-ask-why\skills\never-ask-why "$HOME\.claude\skills\"
```

Then in Claude Code type `/never-ask-why`, or just say "never ask why".

### Codex

Codex reads skills from `~/.codex/skills/`:

```bash
cp -r never-ask-why/skills/never-ask-why ~/.codex/skills/
```

```powershell
Copy-Item -Recurse never-ask-why\skills\never-ask-why "$HOME\.codex\skills\"
```

Then mention the skill in Codex: `$never-ask-why` or "use never-ask-why".

### Project-level install

Drop the folder into `.claude/skills/never-ask-why/` (Claude Code) or `.codex/skills/never-ask-why/` (Codex) inside your repo so teammates get it too.

## Turn it off

Say `stop never ask why` or `normal mode`.

## What it does

- Executes the instruction without asking for motive or confirmation on reversible work.
- Picks a reasonable default on ambiguity instead of asking.
- Replies with the result first, max a few lines of prose.
- Still asks one short question when the task truly cannot proceed (missing path, destructive action).
- Still writes correct code, keeps validation, error handling and security, and reports failures honestly.

## License

MIT
