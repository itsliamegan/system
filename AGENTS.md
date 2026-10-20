# Agent Instructions

Read README.md before changing anything. It describes the layout, where each
tool is installed from, and how versions are pinned.

## Commands

- `bash -n <script>` checks a script's syntax. There are no tests.
- `<domain>/install` installs one domain
- `<domain>/configure` configures one domain
- `setup configure` links configuration files into place, and `setup install`
  installs everything. Both are safe to rerun, but `setup install` takes a long
  time because it rebuilds Emacs and reinstalls every tool. Prefer the narrowest
  script that covers a change.

## Working here

- Commands that use `sudo` ask for a password. Give me the command to run
  instead of running it. Note that `setup configure` uses `sudo` too.
- Don't upgrade or reinstall an agent harness or the app hosting it while it is
  running, because your session may be running inside it.
