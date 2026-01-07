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

Test the curl command. You may need to add `--compressed | jq .` to the end. If it doesn't return the expected results, print "curl command failed" and stop.

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

## Jira

Ask me for my Jira API token and email. Store them temporarily for use in API calls during this session only.

Use the Jira REST API to fetch tickets I worked on for each day in the date range. Put the results in `~/Dropbox/ai-context/daily-work/jira/2025-07-21.txt`. Skip any dates whose files already exist. If there were no tickets on the day, create an empty file `2025-07-21.txt`. If there was an error, do not create any file, and try to figure out what went wrong - try sleeping for 30 seconds if there is a rate limiting error.

Use this curl command pattern:

```bash
curl -s -u "$EMAIL:$API_TOKEN" -X GET \
  "https://adroll.atlassian.net/rest/api/3/search?jql=assignee%20%3D%20currentUser()%20AND%20updated%20%3E%3D%20%222025-07-21%22%20AND%20updated%20%3C%20%222025-07-22%22&maxResults=100&expand=comments" \
  -H "Accept: application/json"
```

Format each ticket entry like this:

```
--------------------------------------------------

Ticket: ABC-1234
Summary: Fix the database connection issue
Status: Done
Created: 2025-07-21 09:15:23
Updated: 2025-07-21 14:30:45
URL: https://adroll.atlassian.net/browse/ABC-1234

Description:
[ticket description text]

Comments:
- 2025-07-21 10:30:12 (jonathan.aquino): Started investigating the connection pool settings
- 2025-07-21 14:28:03 (jane.doe): Looks good, approved for merge
```

Use jq to parse the JSON response and extract: key, summary, status, created, updated, description, and all comments with timestamps and authors. IMPORTANT: Just run the curl commands - don't make a script, as the script will often have bugs. Add `sleep 0.5` between requests to avoid rate limiting.

## Claude Code Conversations

Extract my messages from Claude Code conversation logs for each day in the date range. Put the results in `~/Dropbox/ai-context/daily-work/claude-code/2025-07-21.txt`. Skip any dates whose files already exist. If there were no conversations on the day, create an empty file `2025-07-21.txt`.

Use this command to extract user messages for a specific date:

```bash
find ~/.claude/projects -name "[0-9a-f]*.jsonl" | xargs cat | jq -r 'select(.timestamp? | contains("2025-07-21")) | select(.type == "user") | select(.message.content | type == "string") | select(.message.content | test("<command-name>|<local-command|Caveat:") | not) | .message.content' 2>/dev/null > ~/Dropbox/ai-context/daily-work/claude-code/2025-07-21.txt
```

This extracts only your typed messages, excluding Claude's responses, tool results, and system-generated messages. Each message will appear on its own line in the output file.

## Summary

For each day in the date range, I would like a summary of my work on that day. Put the results in `~/Dropbox/Jon's Obsidian Vault/Work/Daily Summaries`, for example, `~/Dropbox/Jon's Obsidian Vault/Work/Daily Summaries/2025-07-21-uhura-staging-recovery.md`. Note that it is the date followed by a 3 or 4 word short description. If there is no material for the day, call it `2025-07-21.md` and make it an empty file. Skip any dates whose files already exist.

Use the following as source material:

* `~/Dropbox/ai-context/daily-work/github/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/slack/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/jira/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/claude-code/2025-07-21.txt`
* `~/Dropbox/Jon's Obsidian Vault/Personal/Daily Log/2025-07-21*`

Don't forget the Claude Code conversations and Jira tickets.

## Paragraph Summary

For each day in the date range, I would like a 1-paragraph summary of my work on that day. Put the results in `~/Dropbox/Jon's Obsidian Vault/Work/Daily Paragraph Summaries`, for example, `~/Dropbox/Jon's Obsidian Vault/Work/Daily Paragraph Summaries/2025-07-21-uhura-staging-recovery.md`. Note that it is the date followed by a 3 or 4 word short description. If there is no material for the day, call it `2025-07-21.md` and make it an empty file. Skip any dates whose files already exist.

Use the following as source material:

* `~/Dropbox/ai-context/daily-work/github/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/slack/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/jira/2025-07-21.txt`
* `~/Dropbox/ai-context/daily-work/claude-code/2025-07-21.txt`
* `~/Dropbox/Jon's Obsidian Vault/Personal/Daily Log/2025-07-21*`

Don't forget the Claude Code conversations and Jira tickets.

## Finish

Print "daily work script finished".

## Implementation Notes

### Slack Scraping

1. **Use a shell script file**: Write the curl command to a temp file like `/tmp/slack_search.sh` and execute it from there. This avoids shell escaping issues with the complex cookie strings and multipart form data.

2. **Use `-H 'cookie: ...'` instead of `-b '...'`**: The `-b` option has parsing issues with complex cookie strings that contain special characters.

3. **Correct jq structure**: The API returns nested data - messages are inside `.items[].messages[]`. Use this jq command:
   ```
   jq -r '.items[] | .channel.name as $chan | .messages[0] | "--------------------------------------------------\n\nTimestamp: \(if .ts then (.ts | tonumber | strftime("%Y-%m-%d %H:%M:%S")) else "unknown" end)\nUser: \(.username // "unknown")\nChannel: \($chan // "unknown")\nText: \(.text // "")"'
   ```

4. **Rate limiting**: Add `sleep 0.5` between requests to avoid rate limiting.

5. **Multipart form data**: The `--data-raw` content needs proper line endings. In the shell script, use actual newlines instead of `\r\n` escape sequences.

### GitHub PR Scraping

1. **Use a shell script file**: Similar to Slack, write the fetch logic to a temp file like `/tmp/fetch_prs.sh` to avoid escaping issues.

2. **Validate JSON response**: Check if the result starts with `[` to verify it's a valid JSON array:
   ```bash
   FIRST_CHAR=$(echo "$RESULT" | head -c 1)
   if [[ "$FIRST_CHAR" != "[" ]]; then
       echo "Error - not valid JSON"
       exit 1
   fi
   ```

3. **Rate limiting**: Add `sleep 1` between requests. If you hit rate limits, sleep for 30 seconds and retry.

4. **Empty files for no PRs**: Use `touch "$OUTPUT_FILE"` to create empty files for days with no PRs, so they get skipped on subsequent runs.

### Jira Scraping

1. **API Authentication**: Use basic auth with email and API token: `-u "$EMAIL:$API_TOKEN"`. The user should generate an API token at https://id.atlassian.com/manage-profile/security/api-tokens

2. **JQL date filtering**: Use `updated >= "YYYY-MM-DD" AND updated < "YYYY-MM-DD"` to filter by date range. The `updated` field captures any activity on the ticket (comments, status changes, etc.).

3. **Expand comments**: Always include `expand=comments` in the query parameters to get all comments inline with the issues.

4. **Parse JSON response**: Use jq to format the output. Example command structure:
   ```bash
   curl -s -u "$EMAIL:$API_TOKEN" \
     "https://adroll.atlassian.net/rest/api/3/search?jql=..." \
     -H "Accept: application/json" | \
   jq -r '.issues[] | "--------------------------------------------------\n\nTicket: \(.key)\nSummary: \(.fields.summary)\nStatus: \(.fields.status.name)\nCreated: \(.fields.created)\nUpdated: \(.fields.updated)\nURL: https://adroll.atlassian.net/browse/\(.key)\n\nDescription:\n\(.fields.description.content[0].content[0].text // "No description")\n\nComments:\n\(.fields.comment.comments[] | "- \(.created) (\(.author.displayName)): \(.body.content[0].content[0].text // "")")"'
   ```

5. **Rate limiting**: Add `sleep 0.5` between requests to avoid rate limiting.

6. **Empty files for no tickets**: Use `touch "$OUTPUT_FILE"` to create empty files for days with no Jira activity, so they get skipped on subsequent runs.

7. **Date formatting**: Jira returns ISO 8601 timestamps. You may want to use jq's date functions to format them more readably: `(.created | sub("\\.[0-9]+"; "") | strptime("%Y-%m-%dT%H:%M:%S%z") | strftime("%Y-%m-%d %H:%M:%S"))`.

### Claude Code Conversation Extraction

1. **Session files only**: Use pattern `[0-9a-f]*.jsonl` to match UUID-named session files (main conversations), excluding `agent-*.jsonl` files (background agent operations with ~437 files)

2. **Message filtering chain**: The jq filters are applied in sequence:
   - `select(.timestamp? | contains("YYYY-MM-DD"))` - Filter by date
   - `select(.type == "user")` - Only user messages, not Claude's responses
   - `select(.message.content | type == "string")` - Only text content, excludes tool results (arrays)
   - `select(.message.content | test("<command-name>|<local-command|Caveat:") | not)` - Excludes system messages

3. **File structure**:
   - Session files (e.g., `b8b3da6b-441b-4c7e-a787-64a1614253e4.jsonl`): Main conversation with `isSidechain: false`
   - Agent files (e.g., `agent-a3b64fe.jsonl`): Background agent work with `isSidechain: true`

4. **Output format**: Each message appears on its own line. Messages are already in chronological order from the JSONL files.

5. **Empty files**: If no conversations exist for a date, the output redirection will create an empty file, which is correct behavior for consistency with other data sources.

### Summary Generation

1. **File naming convention**:
   - Days with activity: `2025-10-15-deadlock-oom-fixes.md` (date + 3-4 word description of main activity)
   - Days with no activity: `2025-10-18.md` (just the date, empty file)

2. **Summary structure**: Use this format for Daily Summaries:
   ```markdown
   # Daily Work Summary: YYYY-MM-DD

   ## Main Activities
   [Describe main work items with PR numbers and JIRA tickets]

   ## Slack Discussions
   [Key discussions and coordination]

   ## PRs Merged
   1. repo#number - Title
   ```

3. **Paragraph summary format**: 1-2 sentences capturing the essence of the day's work, mentioning PR numbers and ticket IDs where relevant.

4. **Empty days**: For weekends or days with no work activity, use `touch` to create empty files so they get skipped on subsequent runs.

5. **Batch processing**: Check multiple days at once (5-10 days) to speed up processing, then create summaries for each.

6. **Slack-only days**: If there are Slack discussions but no PRs, still create a summary focusing on the discussions, coordination, and any investigations mentioned.
