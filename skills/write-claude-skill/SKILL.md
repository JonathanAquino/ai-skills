---
name: write-claude-skill
description: How to write a Claude Code skill
---
Add a directory with the skill name to ~/projects/ai-skills/skills. **Use kebab-case for the directory name** (e.g., `foo-bar-baz`). Inside, create a file called SKILL.md that starts with this metadata at the top:

---
name: foo-bar-baz
description: A brief description.
---

**Important:** Both the directory name and the `name` in the metadata must be kebab-case (lowercase with hyphens, like `foo-bar-baz`).

After that put information for the skill.

Commit and push the skill.

After creating the skill, ask the user if they want to symlink it into ~/.claude/skills. If yes, run /install-jona-skill to create the symlink. 
