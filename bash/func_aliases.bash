# every day aliases

bak() {
  cp "$1"{,.bak} && echo "Backed up '$1' -> '$1.bak'"
}

dir-size() {
  du -sh "${1:-.}"/* | sort -h
}

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

extract() {
  if [[ -f "$1" ]]; then

    case "$1" in
      *.tar.bz2)  tar xjf "$1"    ;;
      *.tar.gz)   tar xzf "$1"    ;;
      *.tar.xz)   tar xJf "$1"    ;;
      *.bz2)      bunzip2 "$1"    ;;
      *.rar)      unrar e "$1"    ;;
      *.gz)       gunzip "$1"     ;;
      *.tar)      tar xf "$1"     ;;
      *.tbz2)     tar xjf "$1"    ;;
      *.tgz)      tar xzf "$1"    ;;
      *.zip)      unzip "$1"      ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1"       ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac

  else
    echo "'$1' is not a valid file"
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
  doas sv status /var/service/* | awk '{gsub(/\<run\>/, "\033[32m&\033[0m"); gsub(/\<down\>/, "\033[31m&\033[0m")}1' | column -t
}

svenable() {
  local services_dir="/etc/sv"

  for service in "$@"; do
    if [ -d "$services_dir/$service" ]; then doas ln -sv "/etc/sv/$service" /var/service/;
    else echo "Can't find service name $service"; fi
  done
}

svdisable() {
  local services_dir="/etc/sv"

  for service in "$@"; do
    if [ -d "$services_dir/$service" ]; then doas sv down "$@" && doas rm -i "/var/service/$service";
    else echo "Can't find service name $service"; fi
  done
}
