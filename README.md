# Never Ask Why

A skill and plugin for **Claude Code** and **OpenAI Codex** that makes the agent execute your instruction immediately: no "why do you want this?", no plan discussion, no alternatives, no long recap. Saves tokens, saves time.

## Install

### Claude Code, as a plugin (recommended)

The plugin adds the skill **and** a `UserPromptSubmit` hook that reminds the agent on every prompt, so it cannot drift back to long answers.

```
/plugin install never-ask-why --marketplace belimbingwuluh78-maker/never-ask-why
```

Or in two steps:

```
/plugin marketplace add belimbingwuluh78-maker/never-ask-why
/plugin install never-ask-why@never-ask-why
```

### Claude Code and Codex, as a plain skill

One command installs the skill into `~/.claude/skills`, `~/.codex/skills` and `~/.agents/skills`:

```bash
git clone https://github.com/belimbingwuluh78-maker/never-ask-why.git && sh never-ask-why/install.sh
```

Windows PowerShell:

```powershell
git clone https://github.com/belimbingwuluh78-maker/never-ask-why.git; .\never-ask-why\install.ps1
```

Then:

- Claude Code: type `/never-ask-why`, or say "never ask why".
- Codex: type `$never-ask-why`, or say "use never-ask-why". Codex also picks it up when your prompt matches the description.

### Project-level install

Install either the plugin or the plain skill, not both, or Claude Code sees the skill twice.

Copy `skills/never-ask-why/` into `.claude/skills/` (Claude Code) or `.codex/skills/` (Codex) inside your repo so teammates get it too.

## Levels

| Level | Output |
|-------|--------|
| `lite` | Result first, then up to 5 lines of prose. |
| `full` | Result first, max 3 lines of prose. Default. |
| `ultra` | Code, diff, path or command output only. Zero prose unless something failed. |

Switch with `/never-ask-why ultra` or just say the word.

## Turn it off

Say `stop never ask why` or `normal mode`. Plugin users: `/plugin disable never-ask-why` stops the hook.

## What changes

Request: `add a retry to fetchUser`

| | Typical reply | Chars | Approx. tokens |
|---|---|---|---|
| Without | "Sure! Before I do that, can I ask why you need retries here? There are a few approaches: a simple loop, exponential backoff, or a library like p-retry. Each has trade-offs... Let me know which you prefer and I'll implement it." Then a second round trip for your answer. | 226 + your reply | ~57 + a whole extra turn |
| With (`full`) | `src/api/user.ts: fetchUser now retries 3x with 500ms backoff on network errors.` | 79 | ~20 |
| With (`ultra`) | the diff only | 0 prose | 0 prose |

Numbers are illustrative, counted from the two replies above at roughly 4 characters per token. The real saving is the round trip you no longer make.

## Fewer file reads

Most tokens go to reading files, and a new chat reads them all again. The skill fixes that two ways:

- **In a session**: never read a file twice unless it changed, grep first, read only the lines needed.
- **Across sessions**: the agent keeps `.agent-map.md` at your project root, a compact index (one line per file: path, purpose, key symbols). The Claude Code plugin injects it at `SessionStart`, so a new chat reads one small file instead of exploring the tree. The agent updates the map after any task that adds, removes or repurposes a file.

Codex has no plugin hook here, so add one line to your `AGENTS.md`:

```
If .agent-map.md exists, read it first and do not explore the tree. Update it after changing files.
```

Commit `.agent-map.md` so teammates and CI agents get it too.

## What it still does

- Writes correct code, keeps validation, error handling and security.
- Reports failures honestly: a failing test is shown, not hidden.
- Asks **one short line** before destructive or irreversible work: deleting data, `push --force`, dropping a database, spending money, sending or publishing anything.
- Asks when a required input is missing: a path, a credential, a target environment.

## Repo layout

```
.claude-plugin/plugin.json       plugin manifest
.claude-plugin/marketplace.json  lets this repo act as its own marketplace
hooks/hooks.json                 SessionStart map injection + UserPromptSubmit reminder (plugin only)
skills/never-ask-why/SKILL.md    the skill, shared by Claude Code and Codex
install.sh / install.ps1         copy the skill to user-level skill folders
```

## License

MIT
