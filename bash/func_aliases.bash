# every day aliases
git-aliases() {
  git config --get-regexp '^alias\.' | sed 's/^alias\.//' | awk '{printf "\033[36m%-15s\033[0m %s\n", $1, substr($0, index($0,$2))}'
}

key() {
  local ssh="$HOME/.ssh"
  local key="$1"

  if [ -z "${1:-}" ]; then
    echo "No key specify"
    return 1
  fi

  if ssh-keygen -yf "$ssh/$key"; then
    local agent_env="/tmp/agent.$USER.env"

    if ! pgrep -x "ssh-agent" > /dev/null; then
      ssh-agent -s > "$agent_env"
    fi

    . "$agent_env"
    ssh-add "$ssh/$key"
  else
    echo "Invalid key"
  fi
}

# xbps packages
xbps-m-check() {
  for pkg in $(xbps-query -m); do
    revs=$(xbps-query -X "$pkg")
    if [ -n "$revs" ]; then
      printf "\nPackage %s is marked manual, but required by:\n" "$pkg"
      printf "%s " $revs
      printf "\n"
    fi;
  done
}

# void runit services
svlist() {
  local services_dir="/etc/sv"
  local link_dir="/var/service"

  for service in "$services_dir"/*; do

    [ -d "$service" ] || continue

    local name
    name=$(basename "$service")

    if [ -f "$service/down" ]; then printf "%-20s (\033[0;33mdown\033[0m)\n" "$name"
    elif [ -L "$link_dir/$name" ]; then printf "\033[0;32m%-20s\033[0m (\033[0;32menabled\033[0m)\n" "$name"
    else printf "%-20s (\033[0;31mdisabled\033[0m)\n" "$name"; fi

  done
}

svstatus() {
  doas sv status /var/service/* | grep -i "${1:-.}" | awk '{gsub(/\<run\>/, "\033[32m&\033[0m"); gsub(/\<down\>/, "\033[31m&\033[0m")}1'
}

svenable() {
  local services_dir="/etc/sv"

  for service in "$@"; do
    if [ -d "$services_dir/$service" ]; then doas ln -sv "/etc/sv/$service" /var/service/ && doas sv start "$@";
    else echo "Can't find service name $service"; fi
  done
}

svdisable() {
  local services_dir="/etc/sv"

  for service in "$@"; do
    if [ -d "$services_dir/$service" ]; then doas sv down "$@" && doas rm -i "/var/service/$service";
    else echo "Can't find service name $service";fi
  done
}
