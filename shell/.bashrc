export NAME="Liam Egan"
export EMAIL="liam@liamegan.com"

export EDITOR="emacs -nw"

export PS1="[\u@\h] \w\$(indicate_git_status) > "

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

export ASPELL_CONF="home-dir $XDG_DATA_HOME/aspell"

export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"
export PI_CODING_AGENT_DIR="$XDG_CONFIG_HOME/pi"
export PI_CODING_AGENT_SESSION_DIR="$XDG_STATE_HOME/pi/sessions"

export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history"
export npm_config_cache="$XDG_CACHE_HOME/npm"

alias ls="ls --color --classify --group-directories-first"
alias grep="grep --color"
alias fd="fdfind --color=never"

source /usr/share/bash-completion/completions/git

indicate_git_status() {
	branch=$(git branch 2>/dev/null | grep "^*" | sed "s/* \(.*\)/\1/")
	unstaged_changes=$(git diff HEAD 2>/dev/null)
	untracked_files=$(git ls-files --others --exclude-standard 2>/dev/null)
	changes=""

	if [ -z "$branch" ]; then
		printf ""
		return
	fi

	if [ -n "$unstaged_changes" -o -n "$untracked_files" ]; then
		changes="*"
	fi

	printf "(%s%s)" "$branch" "$changes"
}
