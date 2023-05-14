#!/user/bin/env bash

session=$(find ~/Projects -mindepth 1 -maxdepth 1 -type d | fzf)
session_name=$(basename "$session" | tr . _);

if ! tmux has-session -t "$session_name" 2> /dev/null ; then 
    tmux new-session -s "$session_name" -c "$session" -d
fi

#If we are not in a TMUX session
if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
    tmux attach-session -t "$session_name"
else
    tmux switch-client -t "$session_name"
fi
