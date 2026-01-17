---
name: jon-blog-post-draft
description: This skill helps draft blog posts in Jon Aquino's distinctive writing style for his blog "Jon Aquino's Mental Garden" (jona.ca).
---

# Drafting Blog Posts for jona.ca

## Writing Style Characteristics

Jon's blog posts are characterized by:

### Brevity and Directness
- **Short, declarative sentences.** No fluff.
- Gets straight to the point without lengthy introductions
- Paragraphs are typically 1-3 sentences
- Prefers concrete facts over abstract explanations

### Conversational but Technical
- First-person perspective ("I switched to...", "I've been using...")
- Mentions specific tools, versions, and technical details
- Mixes practical observations with genuine enthusiasm
- Honest about limitations and trade-offs

### Structure Patterns
- Often uses bullet points or numbered lists for features/benefits
- Includes screenshots or images when showing something visual
- Links to external resources (tools, documentation)
- Short posts are common—many are just 2-4 paragraphs

### Tone
- Personal discovery/appreciation rather than formal tutorials
- Decisive ("I'm going with X") while acknowledging alternatives
- Values-aware—sometimes mentions ethical considerations alongside technical ones
- Enthusiastic but not hyperbolic

## Examples from jona.ca

### Example 1: Tool Announcement (Short)
> **YubNub Upgraded to Ubuntu 24.04**
>
> YubNub has been upgraded from Ubuntu 12.04 (yes, it was 13 years old) to Ubuntu 24.04, with PHP 8.3, MySQL 8.0, and HTTPS.
>
> I'm not a server admin, but Claude Code helped with everything from Apache configuration to SSL certificate setup to handling MySQL strict mode issues with legacy data.
>
> The migration went smoothly with zero downtime during the DNS cutover. Having an AI assistant for infrastructure work is like having a senior sysadmin on call.

### Example 2: Tool Comparison (Medium)
> **Settling on Claude**
>
> I've decided to go with Claude as my main subscription AI.
>
> Since I use Claude Code for development, it made sense to use the same tool for general queries. Other factors: skepticism about ChatGPT's rumored adult features, confidence in Anthropic's ethical direction (they have an in-house philosopher), and optimism about their path to profitability compared to OpenAI's financial situation.
>
> Claude can't generate images, so I'll still use Gemini or ChatGPT for that.

### Example 3: Feature Discovery (Short with Visuals)
> **Customizing the Omarchy screensaver**
>
> One thing I love about Omarchy: you can change the screensaver by editing a text file.
>
> [Screenshot 1] [Screenshot 2] [Screenshot 3]
>
> Here's a tool for creating ASCII art with the Delta Corps Priest 1 font: [link]

### Example 4: List-Based Post
> **Things I love using my command-line AI tool for**
>
> - Resolving merge conflicts
> - Code reviews with contextual annotations
> - "Commit, push, use gh to make a pr"
> - Combining Google Calendar, Todoist, and Streaks into a daily summary
> - Checking PagerDuty incidents and pulling Confluence runbooks
> - Creating Jira tickets from Slack conversations
> - Calculating lawn irrigation needs from rainfall data

## Workflow

1. **Draft the post** in `/tmp/blog-post-draft.md`
2. **Copy to clipboard** using `wl-copy` when complete

## Instructions

When drafting a blog post:

1. Ask me what I want to write about
2. Draft the post in Jon's style:
   - Start with the main point immediately
   - Keep sentences short and direct
   - Use first person
   - Include specific technical details when relevant
   - Add bullet points for lists of features/items
   - Keep it brief—most posts are 100-300 words
3. Write the draft to `/tmp/blog-post-draft.md`
4. Copy the contents to clipboard with `wl-copy`
5. Show me the draft and ask for feedback

## Post Format

```markdown
# [Title]

[Opening sentence that states the main point]

[1-3 short paragraphs with details]

[Optional: bullet list of features/benefits]

[Optional: link to relevant resource]
```
