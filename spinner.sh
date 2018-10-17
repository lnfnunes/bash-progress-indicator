#!/bin/bash -e

declare -x SPINNER
declare -x SPINNER_INTERVAL

set_spinner() {
  case $1 in
    spinner1)
      SPINNER=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
      SPINNER_INTERVAL=0.1
      ;;
    spinner2)
      SPINNER=("-" "\\" "|" "/")
      SPINNER_INTERVAL=0.25
      ;;
    spinner3)
      SPINNER=("◐" "◓" "◑" "◒")
      SPINNER_INTERVAL=0.5
      ;;
    spinner4)
      SPINNER=(":(" ":|" ":)" ":D")
      SPINNER_INTERVAL=0.5
      ;;    
    *)
      echo "No spinner is defined for $1"
      exit 1
  esac
}

start() {
  local step=0

  tput civis -- invisible

  while [ "$step" -lt "${#CMDS[@]}" ]; do
    ${CMDS[$step]} & pid=$!

    while ps -p $pid &>/dev/null; do
      echo -ne "\\r[   ] ${STEPS[$step]} ..."

      for k in "${!SPINNER[@]}"; do
        echo -ne "\\r[ ${SPINNER[k]} ]"
        sleep $SPINNER_INTERVAL
      done
    done

    echo -ne "\\r[ ✔ ] ${STEPS[$step]}\\n"
    step=$((step + 1))
  done

  tput cnorm -- normal
}
