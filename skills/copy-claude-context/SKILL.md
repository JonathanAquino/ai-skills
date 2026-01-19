---
name: copy-claude-context
description: Copy Claude Code project context from one directory to another
---

1. Ask user for source directory (e.g., `~/projects/foo`)
2. Ask user for target directory (e.g., `~/Documents/AI_Context/foo`)
3. Convert paths to Claude project directory names:
   - Replace `/` with `-`
   - Replace spaces with `-`
   - Prepend `-`
   - Resolve symlinks first (e.g., `~/Documents` → `~/Dropbox/T490/Documents`)
4. Copy: `cp -r ~/.claude/projects/<source> ~/.claude/projects/<target>`

## Path encoding examples

| Real path | Claude projects path |
|-----------|---------------------|
| `/home/jon/projects/foo` | `-home-jon-projects-foo` |
| `/home/jon/projects/foo bar` | `-home-jon-projects-foo-bar` |
| `~/Documents/AI_Context/x` | `-home-jon-Dropbox-T490-Documents-AI-Context-x` (symlink resolved) |
