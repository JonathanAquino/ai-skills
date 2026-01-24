---
name: write-claude-skill
description: How to write a Claude Code skill
---
Add a directory with the skill name to ~/projects/ai-skills/skills, e.g., foo-bar-baz. Inside, create a file called SKILL.md that starts with this metadata at the top:

---
name: The name of the skill
description: A brief description.
---

After that put information for the skill.

Commit and push the skill.

After creating the skill, ask the user if they want to symlink it into ~/.claude/skills. If yes, run /install-jona-skill to create the symlink. 
