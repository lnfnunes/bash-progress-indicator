#!/bin/bash -e

declare -x FRAME
declare -x FRAME_INTERVAL

set_spinner() {
  case $1 in
    spinner1)
      FRAME=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
      FRAME_INTERVAL=0.1
      ;;
    spinner2)
      FRAME=("-" "\\" "|" "/")
      FRAME_INTERVAL=0.25
      ;;
    spinner3)
      FRAME=("◐" "◓" "◑" "◒")
      FRAME_INTERVAL=0.5
      ;;
    spinner4)
      FRAME=(":(" ":|" ":)" ":D")
      FRAME_INTERVAL=0.5
      ;;
    spinner5)
      FRAME=("◇" "◈" "◆")
      FRAME_INTERVAL=0.5
      ;;
    spinner6)
      FRAME=("⚬" "⚭" "⚮" "⚯")
      FRAME_INTERVAL=0.25
      ;;
    spinner7)
      FRAME=("░" "▒" "▓" "█" "▓" "▒")
      FRAME_INTERVAL=0.25
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

      for k in "${!FRAME[@]}"; do
        echo -ne "\\r[ ${FRAME[k]} ]"
        sleep $FRAME_INTERVAL
      done
    done

    echo -ne "\\r[ ✔ ] ${STEPS[$step]}\\n"
    step=$((step + 1))
  done

  tput cnorm -- normal
}

set_spinner "$1"
