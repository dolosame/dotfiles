lastcommand() {
  history 1 | sed 's/^[ ]*[0-9]*[ ]*//'
}

deleteprompt() {
  local n="${PS1@P}"
  n="${n//[^$'\n']}"
  tput cuu $(( ${#n} + 1 ))
  tput ed
}

PS0='\[$(deleteprompt)\] $(lastcommand)\n\[${PS1:0:$((EXPS0=1,0))}\]'
