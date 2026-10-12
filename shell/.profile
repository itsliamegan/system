set -a
eval "$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)"
set +a

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi
