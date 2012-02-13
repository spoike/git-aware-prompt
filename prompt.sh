function find_git_branch {
   local dir=. head
   until [ "$dir" -ef / ]; do
      if [ -f "$dir/.git/HEAD" ]; then
         head=$(< "$dir/.git/HEAD")
         if [[ $head == ref:\ refs/heads/* ]]; then
            git_branch="(${head#*/*/})"
            git_ws=' '
         elif [[ $head != '' ]]; then
            git_branch='(detached)'
            git_ws=' '
         else
            git_branch='(unknown)'
            git_ws=' '
         fi
         return
      fi
      dir="../$dir"
   done
   git_branch=''
   git_ws=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Default Git enabled prompt
# export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
