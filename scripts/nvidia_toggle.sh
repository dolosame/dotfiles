#!/usr/bin/env bash

script_name=$(basename "$0")

# Warn script need to run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: Please run the script as root user." >&2
  exit 1
fi

show_help() {
  cat << EOF

  Enable/Disable nvidia gpu on optimus devices (use your nvidia dGpu with your iGpu or disable it to use iGpu to save battery for laptop devices *experimental)

  Usage: sudo/doas ./$script_name [options]

    -e, --enable      Enable nvidia
    -d, --disable     Disable nvidia

  Experimental work that i founded on running my system please report at issue if you founded this script does not worked
EOF
}

if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

while [ "$#" -gt 0 ]; do
  case "$1" in

    -e|--enable)
      echo 1 > /sys/bus/pci/rescan
      exit 0
      ;;

    -d|--disable)
      echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
      exit 0
      ;;

    -h|--help)
      show_help
      exit 0
      ;;

    *)
      echo "Error! $1 is not a valid argument."
      exit 1
      ;;

  esac
done
