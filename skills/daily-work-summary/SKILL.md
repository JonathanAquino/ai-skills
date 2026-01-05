---
name: daily-work-summary
description: Generate daily work summaries from Slack messages, GitHub PRs, AI conversations, and Obsidian notes for the past 45 days.
---

# Daily Work Summary Generator

This skill scrapes work activity from multiple sources and generates daily summaries.

## Date Range

Ask me for the start and end dates for the summaries.

## Preamble

The only commands you are allowed to run are read-only commands and file write commands. You are not allowed to run any write or modification commands other than file write commands. You are not allowed to run any destructive commands like delete commands.

## Slack

Ask me for a sample search.modules.messages curl request to get slack search results for "from:@Jon Aquino" for yesterday, sorted by Newest.

Test the curl command. You may need to add `--compressed | jq .` to the end. If it doesn't return the expected results, run `say "curl command failed"` and stop.

I want you to scrape the search results for each day in the date range and put the results in `~/Dropbox/ai-context/daily-work/slack/YYYY-MM-DD.txt`. For example, `~/Dropbox/ai-context/daily-work/slack/2025-07-02.txt`. Skip any dates whose files already exist. To vary the date, set `before:2025-07-03 after:2025-07-01` - note that before is the day after the desired date and after is the date before the desired date. Read the page_count to get the number of pages, and iterate over all pages by varying the page parameter. Make sure to scrape all pages - don't just get the first page. If a page has no results, try to figure out what is wrong. Print the number of messages on each page as you go. IMPORTANT: Just run the curl commands - don't make a script, as the script will often have bugs. Each entry should look like this:

```
--------------------------------------------------

Timestamp: 2025-07-28 19:30:58
User: jonathan.aquino
Channel: dev_sludge_attribution_task_force
Text: I need reviews on my funnel metrics PRs
```

## GitHub

Use this command `gh search prs --author=JonathanAquino-NextRoll --created=2025-07-21 --json number,title,body,url,repository,createdAt,state --limit 20` to put the PR descriptions of PRs I created for each day in the date range. For example, `~/Dropbox/ai-context/daily-work/github/2025-07-21.txt`. Skip any dates whose files already exist. If there were no PRs on the day, create an empty file `2025-07-21.txt`. If there was an error, do not create any file, and try to figure out what went wrong - try sleeping for 30 seconds if there is a rate limiting error.

## Summary

For each day in the date range, I would like a summary of my work on that day. Put the results in `~/Dropbox/Jon's Obsidian Vault/Work/Daily Summaries`, for example, `~/Dropbox/Jon's Obsidian Vault/Work/Daily Summaries/2025-07-21-uhura-staging-recovery.md`. Note that it is the date followed by a 3 or 4 word short description. If there is no material for the day, call it `2025-07-21.md` and make it an empty file. Skip any dates whose files already exist.

Use the following as source material:

* `~/Dropbox/ai-context/daily-work/github/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/slack/2025-07-21.txt`
* `~/.claude/projects` - use rg to find entries by YYYY-MM-DD (conversations with AI coding tools)
* `~/Dropbox/Jon's Obsidian Vault/Personal/Daily Log/2025-07-21*`

Don't forget the conversations with AI coding tools.

## Paragraph Summary

For each day in the date range, I would like a 1-paragraph summary of my work on that day. Put the results in `~/Dropbox/Jon's Obsidian Vault/Work/Daily Paragraph Summaries`, for example, `~/Dropbox/Jon's Obsidian Vault/Work/Daily Paragraph Summaries/2025-07-21-uhura-staging-recovery.md`. Note that it is the date followed by a 3 or 4 word short description. If there is no material for the day, call it `2025-07-21.md` and make it an empty file. Skip any dates whose files already exist.

Use the following as source material:

* `~/Dropbox/ai-context/daily-work/github/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/slack/2025-07-21.txt`
* `~/.claude/projects` - use rg to find entries by YYYY-MM-DD (conversations with AI coding tools)
* `~/Dropbox/Jon's Obsidian Vault/Personal/Daily Log/2025-07-21*`

Don't forget the conversations with AI coding tools.

## Finish

Run `say "daily work script finished"`.
