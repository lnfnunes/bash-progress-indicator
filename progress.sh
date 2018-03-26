#!/bin/bash -e

declare -rx BAR_SIZE="##########"
declare -rx CLEAR_LINE="\\033[K"

start() {
  local MAX_STEPS=${#STEPS[@]}
  local MAX_BAR_SIZE="${#BAR_SIZE}"

  tput civis -- invisible

  echo -ne "\\r[${BAR_SIZE:0:0}] 0 %$CLEAR_LINE"
  for step in "${!STEPS[@]}"; do
    ${CMDS[$step]}

    perc=$(((step + 1) * 100 / MAX_STEPS))
    percBar=$((perc * MAX_BAR_SIZE / 100))
    echo -ne "\\r[${BAR_SIZE:0:percBar}] $perc %$CLEAR_LINE"
  done
  echo ""

  tput cnorm -- normal
}
