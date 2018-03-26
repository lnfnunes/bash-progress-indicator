#!/bin/bash -e

start() {
  local MAX_STEPS=${#STEPS[@]}
  local BAR_SIZE="##########"
  local MAX_BAR_SIZE="${#BAR_SIZE}"
  local CLEAR_LINE="\\033[K"

  tput civis -- invisible

  for step in "${!STEPS[@]}"; do
    perc=$((step * 100 / MAX_STEPS))
    percBar=$((perc * MAX_BAR_SIZE / 100))
    echo -ne "\\r- ${STEPS[step]} [ ]$CLEAR_LINE\\n"
    echo -ne "\\r[${BAR_SIZE:0:percBar}] $perc %$CLEAR_LINE"

    ${CMDS[$step]}

    perc=$(((step + 1) * 100 / MAX_STEPS))
    percBar=$((perc * MAX_BAR_SIZE / 100))
    echo -ne "\\r\\033[1A- ${STEPS[step]} [✔]$CLEAR_LINE\\n"
    echo -ne "\\r[${BAR_SIZE:0:percBar}] $perc %$CLEAR_LINE"
  done
  echo ""

  tput cnorm -- normal
}
