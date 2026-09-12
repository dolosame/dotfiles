#!/usr/bin/env bash

script_name=$(basename "$0")

have_nvidia=1
use_nvidia=1

igpu=""
dgpu=""

# Warn script need to run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: Please run the script as root user." >&2
  echo "DO NOT RUN THIS SCRIPT IF YOU DON'T KNOW WHAT ARE YOU DOING, I HAVE FOUNDED MY OWN WAY TO TURN NVIDIA ON AND OFF ON MY DEVICE, CHECK THE NVIDIA TOGGLE SCRIPT" 
  exit 1
fi

# Define functions
show_help() {
  cat << EOF

  Enable/Disable nvidia scripts (use your nvidia dGpu or disable it to save battery for laptop devices)

  Usage: sudo/doas ./$script_name [options]

    -e, --enable      Enable nvidia
    -d, --disable     Disable nvidia
    -h, --help        Display this message
    -l, --devices     List all your gpu devices on system with PCI num

  This script only put nvidia config file inside their repected directory,
  you might need to query the dgpu or rebuild dracut to take effect.
EOF
}

list_gpu_devices() {
  igpu=$(lspci | grep -iE 'vga|3d|display' | grep -iE 'intel|amd')
  dgpu=$(lspci | grep -iE 'vga|3d|display' | grep -i 'nvidia')

  if [ -n "$igpu" ] && [ -n "$dgpu" ]; then 
    have_nvidia=1
    printf "Devices in your system:  -%s\n  -%s\n" "$igpu" "$dgpu"
  else 
    have_nvidia=0
    printf "There are no nvidia on this system only igpu:\n  -%s\n" "$igpu"
  fi
}

# Function write to directory in linux
write_to_udev_rule() {
  udev_rule_dir="/etc/udev/rules.d"
  rule_file="$udev_rule_dir/50-remove-nvidia.rules"

  if [ ! -d "$udev_rule_dir" ]; then 
    echo "There are no directory $udev_rule_dir making one..."
    mkdir -p "$udev_rule_dir"
  fi

  if [ ! -f "$rule_file" ] && [ ! -f "$rule_file.bak" ] ; then
    printf "\nNot found udev nvidia file in %s creating one...\n" "$udev_rule_dir"
    tee -a /etc/udev/rules.d/50-remove-nvidia.rules <<- 'EOF'
		# Remove NVIDIA USB xHCI Host Controller devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

		# Remove NVIDIA USB Type-C UCSI devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

		# Remove NVIDIA Audio devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

		# Remove NVIDIA VGA/3D controller devices
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
		EOF
  fi

  if [ "$use_nvidia" -eq 1 ]; then
    if [ -f "$rule_file" ]; then mv "$rule_file" "$rule_file.bak"; fi
  else
    if [ -f "$rule_file.bak" ]; then mv "$rule_file.bak" "$rule_file"; fi
  fi
}

write_to_modprobe.d () {
  modprobe_dir="/etc/modprobe.d"
  nvidia_file="$modprobe_dir/nvidia.conf"
  blacklist_nvidia_file="$modprobe_dir/blacklist-nvidia.conf"

  if [ ! -f "$nvidia_file" ] && [ ! -f "$nvidia_file.bak" ] ; then
    printf "\nNot found nvidia file in %s creating one...\n" "$modprobe_dir"
    tee -a /etc/modprobe.d/nvidia.conf <<- 'EOF'
		options nvidia_drm modeset=1 fbdev=1
		options nvidia NVreg_PreserveVideoMemoryAllocations=1
		EOF
  fi

  if [ ! -f "$blacklist_nvidia_file" ] && [ ! -f "$blacklist_nvidia_file.bak" ]; then
    printf "\nNot found blacklist file in %s creating one...\n" "$modprobe_dir"
    tee -a /etc/modprobe.d/blacklist-nvidia.conf <<- 'EOF'
		blacklist nvidia
		blacklist nvidia_drm
		blacklist nvidia_uvm
		blacklist nvidia_modeset
		blacklist nvidia_current
		blacklist nvidia_current_drm
		blacklist nvidia_current_uvm
		blacklist nvidia_current_modeset
		blacklist i2c_nvidia_gpu

		alias nvidia off
		alias nvidia_drm off
		alias nvidia_uvm off
		alias nvidia_modeset off
		alias nvidia_current off
		alias nvidia_current_drm off
		alias nvidia_current_uvm off
		alias nvidia_current_modeset off
		alias i2c_nvidia_gpu off
		EOF
  fi

  if [ "$use_nvidia" -eq 1 ]; then
    echo "Enable nvidia in $modprobe_dir..."
    if [ -f "$nvidia_file.bak" ]; then mv "$nvidia_file.bak" "$nvidia_file"; fi
    if [ -f "$blacklist_nvidia_file" ]; then mv "$blacklist_nvidia_file" "$blacklist_nvidia_file.bak"; fi
  else
    echo "Disable nvidia in $modprobe_dir..."
    if [ -f "$nvidia_file" ]; then mv "$nvidia_file" "$nvidia_file.bak"; fi
    if [ -f "$blacklist_nvidia_file.bak" ]; then mv "$blacklist_nvidia_file.bak" "$blacklist_nvidia_file"; fi
  fi
}

enable_nvidia() {
  #Check if have nvidia
  list_gpu_devices > /dev/null

  write_to_udev_rule
  write_to_modprobe.d
}

if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

while [ "$#" -gt 0 ]; do
  case "$1" in

    -e|--enable)
      use_nvidia=1
      enable_nvidia
      exit 0
      ;;

    -d|--disable)
      use_nvidia=0
      enable_nvidia
      exit 0
      ;;

    -h|--help)
      show_help
      exit 0
      ;;

    -l|--devices)
      list_gpu_devices
      exit 0
      ;;

    *)
      echo "Error! $1 is not a valid argument."
      exit 1
      ;;

  esac
done
