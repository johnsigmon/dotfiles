
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/serverless.bash ] && . /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/sls.bash ] && . /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/slss.bash ] && . /Users/jsigmon/SE_Builds/Lamdas/transform-lambdas/node_modules/tabtab/.completions/slss.bash

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
