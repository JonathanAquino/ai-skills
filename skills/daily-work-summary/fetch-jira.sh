#!/bin/bash
set -euo pipefail

# Usage: fetch-jira.sh START_DATE END_DATE
# Example: fetch-jira.sh 2025-11-01 2025-11-30
#
# Environment variables required:
#   JIRA_EMAIL - Your Jira account email
#   JIRA_API_TOKEN - Your Jira API token from https://id.atlassian.com/manage-profile/security/api-tokens

if [ $# -ne 2 ]; then
    echo "Usage: $0 START_DATE END_DATE"
    echo "Example: $0 2025-11-01 2025-11-30"
    exit 1
fi

START_DATE="$1"
END_DATE="$2"
OUTPUT_DIR="$HOME/Documents/ai-context/daily-work/jira"

if [ -z "${JIRA_EMAIL:-}" ] || [ -z "${JIRA_API_TOKEN:-}" ]; then
    echo "Error: JIRA_EMAIL and JIRA_API_TOKEN environment variables must be set"
    echo "Generate a token at: https://id.atlassian.com/manage-profile/security/api-tokens"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "Fetching Jira tickets from $START_DATE to $END_DATE..."

# Calculate the day after END_DATE for proper range query
# (resolved >= START AND resolved < END+1 captures the full END day)
END_DATE_PLUS_ONE=$(date -d "$END_DATE + 1 day" +%Y-%m-%d)

# Fetch tickets for the date range
RESPONSE=$(curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" -X GET \
  "https://adroll.atlassian.net/rest/api/3/search/jql?jql=assignee%20%3D%20currentUser()%20AND%20statusCategory%20%3D%20Done%20AND%20resolved%20%3E%3D%20%22${START_DATE}%22%20AND%20resolved%20%3C%20%22${END_DATE_PLUS_ONE}%22%20ORDER%20BY%20created%20DESC&maxResults=1000&expand=comments&fields=summary,status,created,updated,resolutiondate,description,comment,customfield_13337" \
  -H "Accept: application/json")

# Check for errors
if echo "$RESPONSE" | jq -e '.errorMessages' > /dev/null 2>&1; then
    echo "Error from Jira API:"
    echo "$RESPONSE" | jq -r '.errorMessages[]'
    exit 1
fi

# Count tickets
TICKET_COUNT=$(echo "$RESPONSE" | jq -r '.issues | length')
echo "Found $TICKET_COUNT tickets"

if [ "$TICKET_COUNT" -eq 0 ]; then
    echo "No tickets found in this range"
    # Create empty files for each date in range
    current="$START_DATE"
    while [[ "$current" < "$END_DATE" ]] || [[ "$current" == "$END_DATE" ]]; do
        output_file="$OUTPUT_DIR/${current}.txt"
        if [ ! -f "$output_file" ]; then
            touch "$output_file"
            echo "Created empty file: $output_file"
        fi
        current=$(date -d "$current + 1 day" +%Y-%m-%d)
    done
    exit 0
fi

# Process tickets and group by resolution date
echo "$RESPONSE" | jq -r '
def extract_text:
  if type == "object" then
    if .type == "text" then .text
    elif .type == "hardBreak" then "\n"
    elif .type == "paragraph" then ((.content // []) | map(extract_text) | join("")) + "\n\n"
    elif .content then .content | map(extract_text) | join("")
    else "" end
  elif type == "array" then map(extract_text) | join("")
  else "" end;

.issues[] |
{
  key: .key,
  summary: .fields.summary,
  status: .fields.status.name,
  created: .fields.created,
  updated: .fields.updated,
  resolved: .fields.resolutiondate,
  url: ("https://adroll.atlassian.net/browse/" + .key),
  description: (
    if .fields.customfield_13337 then (.fields.customfield_13337 | extract_text)
    elif .fields.description then (.fields.description | extract_text)
    else "No description" end
  ),
  comments: [
    .fields.comment.comments[]? |
    "- \(.created) (\(.author.displayName)): \(.body | extract_text)"
  ]
} |
"RESDATE:" + (.resolved | split("T")[0]) + "\n" +
"--------------------------------------------------\n\n" +
"Ticket: \(.key)\n" +
"Summary: \(.summary)\n" +
"Status: \(.status)\n" +
"Created: \(.created)\n" +
"Updated: \(.updated)\n" +
"Resolved: \(.resolved)\n" +
"URL: \(.url)\n\n" +
"Description:\n\(.description)\n\n" +
"Comments (\(.comments | length)):\n" +
(if (.comments | length) > 0 then (.comments | join("\n\n")) else "(No comments)" end)
' | awk -v outdir="$OUTPUT_DIR" '
BEGIN { current_file = ""; content = "" }
/^RESDATE:/ {
    if (current_file != "") {
        # Write previous file
        print content > current_file
        close(current_file)
        print "Wrote: " current_file > "/dev/stderr"
    }
    # Extract date and set new file
    date = substr($0, 9)
    current_file = outdir "/" date ".txt"
    content = ""
    next
}
{
    if (content != "") content = content "\n"
    content = content $0
}
END {
    if (current_file != "") {
        print content > current_file
        close(current_file)
        print "Wrote: " current_file > "/dev/stderr"
    }
}
'

# Create empty files for dates with no tickets
current="$START_DATE"
while [[ "$current" < "$END_DATE" ]] || [[ "$current" == "$END_DATE" ]]; do
    output_file="$OUTPUT_DIR/${current}.txt"
    if [ ! -f "$output_file" ]; then
        touch "$output_file"
        echo "Created empty file: $output_file"
    fi
    current=$(date -d "$current + 1 day" +%Y-%m-%d)
done

echo "Done! Processed date range: $START_DATE to $END_DATE"
