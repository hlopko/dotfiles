#!/bin/bash

# print the time it took to start

main() {
  print_runtime > /dev/null
  print_runtime
}

print_runtime() {
  pid=$(start_server)
  runtime=$(time_command wait_for_server)
  baseline=$(time_command wait_for_server)
  kill -9 $pid
  echo $runtime - $baseline | bc
}

start_server() {
  rails server >/dev/null 2>&1 &
  echo $!
}

time_command() {
  local cmd=$*
  TIMEFORMAT="%3R"
  (time $cmd) 2>&1
}

wait_for_server() {
  while true; do
    lsof -i :3000 > /dev/null
    if [[ $? == 0 ]]; then
      break
    fi
  done
}

main
