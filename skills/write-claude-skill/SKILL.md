---
name: write-claude-skill
description: How to write a Claude Code skill
---
Add a directory with the skill name to /home/jon/projects/ai-skills/skills, e.g., foo-bar-baz. Inside, create a file called SKILL.md that starts with this metadata at the top:

---
name: The name of the skill
description: A brief description.
---

After that put information for the skill.

Commit and push the skill.

After creating the skill, run /home/jon/.local/bin/sync-ai-skills to copy the skills to the final place. 
