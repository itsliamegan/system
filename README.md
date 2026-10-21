# System Configuration

This repository contains system configuration files as well as scripts for
setting up and maintaining a system. These files are designed to work on Debian
(unstable) with KDE Plasma, Firefox, Emacs, Bash, and other tools.

## Usage

The `setup` script is the central entry point for all system configuration.
`setup install` installs all the necessary packages. `setup configure` links
configuration files and makes other tool-specific changes. `configure` depends
on `install` having been run. `setup update` updates the pinned versions in the
install scripts to their newest releases, which `setup install` then installs.

## Layout

The root of this repository contains the following:

- `setup`: The central setup script.
- `packages`: Core system packages.
- `bin/`: Custom scripts.
- `fonts/`: Fonts, including a submodule for font archives.
- Domain-specific directories.

Each directory relates to a particular domain. A domain corresponds to a single
tool or a set of related tools. For example, the `emacs/` domain contains
`emacs`, its build dependencies, its language servers, and its configuration
files, while the `git` domain contains `git` and its configuration files as well
as the `gh` CLI.

A domain directory can contain an install script, a configure script, an update
script, configuration files, and/or sibling files for things like APT sources.

```
<domain>/
	install   # installs the tool(s) and related packages
	configure # sets up symlinks, configures daemons, etc.
	update    # updates the version pins in the install scripts
	packages  # lists sibling packages
	...       # any other files, lists of packages, configurations, etc.
```

Some directories contain multiple nested tools in a single domain, such as
`langs/`. Each subdirectory has roughly the above structure.

## Tools and Packages

Tools and packages are installed from source, pre-built binaries, or first-party
repositories, falling back to Debian repositories when these methods are not
available or the tool is not important to the system.

Each install script installs a specific minor version, or a patch version if the
installer only permits the latter. If the tool is self-updating, like Pi, the
latest version is installed instead.

Different package sources have different conventions:
- A third-party Debian repository is configured by a `.sources` file that is
  copied into `/etc/apt/`.
- A Rust binary is installed with `cargo install --locked` into
  `~/.local/share/cargo/bin`.
- An npm tool is installed globally into `~/.local`.
- apt packages are installed using the system `apt`.

Tools installed from release tarballs or source install into versioned prefixes:
```
~/.local/src/<name>-<version>
~/.local/opt/<name>-<version>
~/.local/opt/<name> -> <name>-<version>
~/.local/bin/<command> -> ~/.local/opt/<name>/bin/<command>
```

Only the unversioned `~/.local/opt/<name>` is exposed, so upgrading or rolling
back a tool means pointing that link at a different directory.
