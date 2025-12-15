---
name: espanso
description: Expert guidance for working with Espanso text expander configuration files. Use when user mentions espanso, text expansion, snippets, triggers, matches, YAML config files, or needs help creating/editing espanso configurations.
---

# Espanso Configuration Expert

This skill provides comprehensive guidance for working with Espanso, a cross-platform text expander that uses YAML configuration files.

## When to Use This Skill

Activate this skill when the user needs help with:
- Creating or editing espanso configuration files
- Understanding espanso match syntax and triggers
- Setting up text expansion snippets
- Configuring app-specific behaviors
- Troubleshooting espanso issues
- Working with espanso packages
- Using variables, forms, or regex in matches

## Quick Reference

- **Config location**: Run `espanso path` to find config directory
- **Default config**: `config/default.yml`
- **Matches file**: `match/base.yml`
- **File format**: YAML

## Documentation Table of Contents

### Getting Started

#### `docs/get-started.md`
**Purpose**: Introduction to espanso basics and first-time setup
**When to read**: User is new to espanso or needs to understand core concepts
**Key topics**:
- Verifying espanso is running
- Understanding matches (trigger/replace pairs)
- First basic example (`:espanso` → `Hi there!`)
- Troubleshooting startup issues

---

### Configuration

#### `docs/configuration/basics.md`
**Purpose**: Core configuration structure and file organization
**When to read**: User needs to understand where config files live or how they're organized
**Key topics**:
- Config directory location by OS (Linux: `~/.config/espanso`, macOS: `~/Library/Application Support/espanso`, Windows: `%AppData%\espanso`)
- Directory structure (`config/` and `match/` folders)
- YAML file format basics
- `default.yml` vs `base.yml` distinction

#### `docs/configuration/options.md`
**Purpose**: Global configuration options and settings
**When to read**: User wants to customize espanso behavior (toggle keys, timing, backend settings)
**Key topics**:
- Toggle key configuration
- Backend selection (Inject vs Clipboard)
- Timing settings (backspace_delay, pre_paste_delay)
- Search behavior options
- Auto-restart settings

#### `docs/configuration/app-specific-configurations.md`
**Purpose**: Creating configurations that only apply to specific applications
**When to read**: User wants different matches or settings for specific apps
**Key topics**:
- Creating app-specific config files
- Detecting application identifiers
- Filter contexts (app name, class, executable)
- Inheriting from base configuration

#### `docs/configuration/include-and-exclude.md`
**Purpose**: Controlling which files espanso loads and where it's active
**When to read**: User wants to organize configs across multiple files or disable espanso in certain apps
**Key topics**:
- Including external match files
- Using glob patterns
- Excluding applications (blacklist)
- Enabling espanso only in specific apps (whitelist)

---

### Matches

#### `docs/matches/basics.md`
**Purpose**: Fundamental match syntax and static replacements
**When to read**: User is creating their first matches or needs syntax reference
**Key topics**:
- Basic trigger/replace syntax
- Multi-line expansions (`|` and `>` operators)
- Static text replacements
- YAML quoting rules for special characters
- Word triggers vs simple triggers

#### `docs/matches/examples.md`
**Purpose**: Real-world match examples and common patterns
**When to read**: User wants inspiration or templates for common use cases
**Key topics**:
- Email signatures
- Code snippets
- Date/time insertions
- URLs and links
- Form letters
- Common abbreviations

#### `docs/matches/variables.md`
**Purpose**: Dynamic content using variables (dates, clipboard, shell commands)
**When to read**: User wants to insert dynamic content that changes each time
**Key topics**:
- Date variables (`{{mydate}}`)
- Clipboard variables (`{{clipboard}}`)
- Shell command variables (`{{output}}`)
- Choice variables (dropdown selections)
- Echo variables (typed input)
- Custom variable types

#### `docs/matches/forms.md`
**Purpose**: Interactive forms with multiple input fields
**When to read**: User wants to create matches that prompt for multiple values
**Key topics**:
- Multi-field forms
- Input types (text, list, choice)
- Form syntax and structure
- Using form values in replacement text
- Validation and defaults

#### `docs/matches/regex-triggers.md`
**Purpose**: Pattern-based triggers using regular expressions
**When to read**: User needs flexible triggers that match patterns rather than exact text
**Key topics**:
- Regex trigger syntax
- Capture groups
- Using captured values in replacements
- Common regex patterns
- Performance considerations

#### `docs/matches/organizing-matches.md`
**Purpose**: Best practices for structuring match files
**When to read**: User has many matches and needs organization strategies
**Key topics**:
- Splitting matches into multiple files
- Logical grouping strategies
- File naming conventions
- Using includes effectively

#### `docs/matches/quotes.md`
**Purpose**: When and how to quote strings in YAML
**When to read**: User encounters YAML syntax errors or special character issues
**Key topics**:
- When quotes are required
- Single vs double quotes
- Escaping special characters
- Multi-line string quoting

---

### Packages

#### `docs/packages/basics.md`
**Purpose**: Understanding espanso's package system
**When to read**: User wants to install pre-made match collections or share their own
**Key topics**:
- What packages are
- Installing packages from the hub
- Package discovery
- Package management commands

#### `docs/packages/external-packages.md`
**Purpose**: Using third-party packages from sources other than the hub
**When to read**: User wants to install packages from GitHub or other sources
**Key topics**:
- Installing from Git repositories
- Package sources and URLs
- Version management
- Custom package locations

#### `docs/packages/creating-a-package.md`
**Purpose**: Building and publishing your own packages
**When to read**: User wants to create reusable match collections for others
**Key topics**:
- Package structure requirements
- Manifest file format
- Publishing to the hub
- Package metadata

#### `docs/packages/package-specification.md`
**Purpose**: Technical specification for package format
**When to read**: Advanced users building packages or troubleshooting package issues
**Key topics**:
- Package manifest schema
- Required vs optional fields
- Package versioning
- Dependency management

---

### Command Line

#### `docs/command lIne/cli.md`
**Purpose**: Complete CLI reference for espanso commands
**When to read**: User needs to interact with espanso via terminal
**Key topics**:
- Starting/stopping espanso (`espanso start`, `espanso stop`)
- Status checking (`espanso status`)
- Configuration path (`espanso path`)
- Package management (`espanso install`, `espanso uninstall`)
- Editing configs (`espanso edit`)
- Restarting (`espanso restart`)

#### `docs/command lIne/cli_list.md`
**Purpose**: Quick reference list of all CLI commands
**When to read**: User wants a complete command overview
**Key topics**:
- Command summary
- Common flags and options
- Command categories

---

### Additional Resources

#### `docs/security.md`
**Purpose**: Security considerations when using espanso
**When to read**: User has security concerns or works with sensitive data
**Key topics**:
- Secure input mode on macOS
- Password managers and espanso interaction
- Clipboard security
- Shell command execution risks

#### `docs/sync.md`
**Purpose**: Syncing espanso configs across multiple machines
**When to read**: User wants to use same configs on multiple devices
**Key topics**:
- Git-based syncing
- Cloud storage syncing (Dropbox, Google Drive)
- Symlink strategies
- Platform-specific considerations

#### `docs/tools.md`
**Purpose**: Third-party tools and integrations for espanso
**When to read**: User wants to enhance espanso with additional tools
**Key topics**:
- GUI tools
- Package managers
- Editor integrations
- Community tools

#### `docs/troubleshooting/secure-input.md`
**Purpose**: Resolving macOS secure input issues
**When to read**: User on macOS reports espanso not working in certain apps
**Key topics**:
- What secure input mode is
- Detecting which apps enable it
- Workarounds and solutions
- Terminal and IDE-specific issues

---

## Working with Espanso Config Files

### Common Tasks

**Creating a new match:**
```yaml
# In match/base.yml
matches:
  - trigger: ":sig"
    replace: "Best regards,\nJohn Doe"
```

**App-specific config:**
```yaml
# In config/vscode.yml
filter_title: "Visual Studio Code"
matches:
  - trigger: ":log"
    replace: "console.log($|$)"
```

**Using variables:**
```yaml
matches:
  - trigger: ":date"
    replace: "{{mydate}}"
    vars:
      - name: mydate
        type: date
        params:
          format: "%Y-%m-%d"
```

### File Locations

Always suggest using `espanso path` command to find the exact location, as it varies by OS and installation.

### Important Notes

- Changes require reload: `espanso restart` after editing configs
- YAML is whitespace-sensitive (use 2-space indentation)
- Triggers starting with `:` are word triggers (won't expand mid-word)
- Use quotes for strings containing special YAML characters

## Best Practices

1. **Start simple**: Begin with static matches before using variables
2. **Use word triggers**: Prefix with `:` to avoid accidental expansions
3. **Test incrementally**: Add one match at a time and test
4. **Organize by category**: Use separate files for different types of matches
5. **Comment your configs**: YAML supports `#` comments
6. **Backup configs**: Use git or cloud storage for syncing

## Progressive Disclosure

Keep SKILL.md focused on overview and navigation. When user needs specific details:
1. Read the appropriate doc file from the table of contents
2. Extract relevant sections
3. Provide targeted guidance based on that documentation
