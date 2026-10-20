PS1="[\u@\h] \w\$(indicate_git_status) > "

alias ls="ls --color --classify --group-directories-first"
alias grep="grep --color"
alias fd="fd --color=never"

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
