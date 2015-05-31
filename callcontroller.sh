#!/bin/sh
name="${0}"
cmd="${1}"
PIDFile=".callcontroller.pid"

case ${cmd} in
  start)
  unicorn -c unicorn.conf.rb -D
  echo "CallController Started"
  ;;
  stop)
  kill -3 $(cat "$PIDFile")
  echo "CallController Stopped"
  ;;
  restart)
  kill -3 $(cat "$PIDFile")
  sleep 2
  unicorn -c unicorn.conf.rb -D
  echo "CallController Restarted"
  ;;
  *)
  echo "Usage: ${name} {start|stop|restart}"
  exit 1
  ;;
esac
