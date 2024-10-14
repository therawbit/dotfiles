#!/bin/bash
git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    local branch_status
    branch_status=$(git status --porcelain 2>/dev/null)
    
    if [[ -z "$branch_status" ]]; then
      # No changes, clean branch
      echo "%{$fg[green]%}%B[ $branch]%b%{$reset_color%}"
    else
      local untracked_count
      untracked_count=$(echo "$branch_status" | grep '^??' | wc -l)
      local modified_count
      modified_count=$(echo "$branch_status" | grep '^ M' | wc -l)
      
      if [[ "$untracked_count" -gt 0 ]]; then
        # Untracked files
        echo "%{$fg[red]%}%B[ $branch]%b%{$reset_color%}"
      elif [[ "$modified_count" -gt 0 ]]; then
        # Modified files
        echo "%{$fg[yellow]%}%B[ $branch]%b%{$reset_color%}"
      else
        # New files or other changes
        echo "%{$fg[blue]%}%B[ $branch]%b%{$reset_color%}"
      fi
    fi
  fi
}

newline=$'\n'
# PROMPT="%{$fg[magenta]%}╭─╼%{$fg[cyan]%} %{$fg[blue]%}%~ \$(git_branch)${newline}%{$fg[magenta]%}╰──▶ %{$fg[white]%}"
PROMPT="%{$fg[yellow]%} %{$fg[magenta]%}%~\$(git_branch) %{$fg[cyan]%}▶ %{$fg[white]%}"



bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
