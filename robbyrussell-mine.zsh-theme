# vim: set syntax=bash:
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

function git_path_if_exists () {
    local OUT="%c"
    local GIT_ROOT=$(command git rev-parse --show-toplevel 2>/dev/null)

    if [[ -n $GIT_ROOT ]]
    then
        local PWD="$(command pwd)"
        local git_dir=${PWD#"$GIT_ROOT"}
        OUT="$(basename $GIT_ROOT)%{$fg_bold[cyan]%}$git_dir"
    fi
    echo $OUT
}
PROMPT='${ret_status} %{$fg[cyan]%}$(git_path_if_exists)%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
