---
name: install-jona-skill
description: Install a personal skill by symlinking it to ~/.claude/skills/
---

1. List directories in `~/projects/ai-skills/skills/` (excluding this skill)
2. Check which are already symlinked in `~/.claude/skills/` and mark them as "(installed)"
3. Ask user to choose one to install
4. Create symlink: `ln -s ~/projects/ai-skills/skills/<skill> ~/.claude/skills/`
