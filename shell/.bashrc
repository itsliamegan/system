export NAME="Liam Egan"
export EMAIL="liam@liamegan.com"

export EDITOR="emacs -nw"

export PS1="[\u@\h] \w\$(indicate_git_status) > "

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.zig:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export GOPATH="$HOME/.go"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

alias ls="ls --color --classify --group-directories-first"
alias grep="grep --color"

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
