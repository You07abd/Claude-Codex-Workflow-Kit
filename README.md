# Claude + Codex Workflow Kit

A drag-and-drop workflow for using **Claude** and **Codex** together — Claude plans and orchestrates, Codex writes all the code.

Drop two files into any project and the split is active from the next Claude Code session.

---

## How it works

| Role | Tool | Does what |
|------|------|-----------|
| Planner / Orchestrator | Claude (Claude Code) | Understands the goal, breaks it into steps, writes the Codex spec, reviews output |
| Coder / Implementer | Codex CLI | Writes files, runs commands, implements the plan |
| Owner | You | Approves work, commits, pushes — all git operations stay with you |

Claude never writes production code directly. Codex never decides what to build. You always control git.

---

## Prerequisites

- [Claude Code](https://claude.ai/code) — the Claude CLI / IDE extension
- [Codex CLI](https://github.com/openai/codex) — OpenAI's coding agent (`npm install -g @openai/codex`)
- Codex authenticated: run `codex login` once after installing

---

## Install into any project

**Option 1 — Script (recommended)**

From inside your target project, run the installer:

```bash
# bash / Mac / Linux
bash path/to/claude-codex/install.sh

# PowerShell / Windows
powershell -ExecutionPolicy Bypass -File path\to\claude-codex\install.ps1
```

The script copies `CLAUDE.md` and `tasks/_template.md` into your project. If a `CLAUDE.md` already exists, the workflow is merged into it safely.

**Option 2 — Manual drag**

Copy these two items into your project root:

```
CLAUDE.md
tasks/
  _template.md
```

If your project already has a `CLAUDE.md`, paste the contents of this repo's `CLAUDE.md` at the bottom.

Open the project in Claude Code — the workflow is live immediately.

---

## Usage

No special syntax needed. Just describe what you want and the workflow runs automatically.

### Option A — Just talk to Claude (no file needed)

Open any project with this `CLAUDE.md` installed and describe your task:

```
Add JWT login and registration endpoints to the Express API.
Use jsonwebtoken and bcrypt. Don't touch anything outside src/routes/auth.js.
```

Claude plans it, hands the spec to Codex, then reviews the output. That's the whole loop.

### Option B — Task file (for larger or repeated work)

Copy `tasks/_template.md` to `tasks/your-task-name.md`, fill it in, then say:

```
Process tasks/your-task-name.md
```

Task files are useful when a piece of work is too large to describe inline, when you want to save the spec for later, or when you're handing work off. They are never required.

### Review and ship

Once Claude confirms the output looks good, you review it, then commit and push yourself.

---

## Trigger reference

| Say this | What happens |
|----------|--------------|
| `Process tasks/foo.md` | Full pipeline: Claude plans → Codex implements → Claude reviews |
| `Plan tasks/foo.md` | Claude writes the plan only — no Codex run until you approve |
| `Code: <instruction>` | Skip the long plan, send a tight prompt straight to Codex |
| `Review last Codex output` | Claude audits what Codex just produced against the task criteria |
| `Rescue: <problem>` | Codex rescue agent diagnoses and fixes a stuck issue |
| `New task` | Claude helps you fill in the task template interactively |

---

## Git rules

Neither Claude nor Codex will ever commit, push, or take any git action. If a task is complete and needs a commit, Claude will suggest a commit message as text — you run it. This is by design and cannot be overridden by a task file.

---

## Project structure

```
your-project/
├── CLAUDE.md              ← workflow instructions, auto-read by Claude Code
└── tasks/
    ├── _template.md       ← copy this for each new task (gitignored when filled in)
    └── your-task.md       ← your task files (gitignored by default)
```

Task files are gitignored by default because the context section often contains project-specific code or internal details. Only the template is tracked.

---

## License

MIT
