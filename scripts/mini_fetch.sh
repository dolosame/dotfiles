#!/usr/bin/env bash
R=$'\e[38;2;224;86;59m'
RH=$'\e[38;2;239;106;79m'
D=$'\e[38;2;51;55;63m'
K=$'\e[38;2;63;69;80m'
S=$'\e[38;2;139;145;156m'
T=$'\e[38;2;196;204;218m'
DIM=$'\e[38;2;91;102;120m'
G=$'\e[38;2;91;191;115m'
X=$'\e[0m'

printf -v clock "%(%H:%M)T" -1
printf -v day_str "%(%A · %-d %b)T" -1

read -r up_seconds _ < /proc/uptime
up=${up_seconds%.*}
ud=$((up/86400)); uh=$(((up%86400)/3600)); um=$(((up%3600)/60))
if [ "$ud" -gt 0 ]; then upt="${ud}d ${uh}h"; else upt="${uh}h ${um}m"; fi

read -ra a < /proc/stat
sleep 0.08
read -ra b < /proc/stat
t1=0; for v in "${a[@]:1}"; do t1=$((t1+v)); done
t2=0; for v in "${b[@]:1}"; do t2=$((t2+v)); done
id1=$((a[4]+a[5])); id2=$((b[4]+b[5]))
dt=$((t2-t1)); di=$((id2-id1))
cpu=$(( dt>0 ? 100*(dt-di)/dt : 0 ))

ctemp="--"
for hw in /sys/class/hwmon/hwmon*; do
    [ -e "$hw/name" ] || continue
    read -r name < "$hw/name" 2>/dev/null

    if [ "$name" = "k10temp" ] || [ "$name" = "coretemp" ]; then
        for lbl in "$hw"/temp*_label; do
            [ ! -e "$lbl" ] && continue
            read -r lbl_val < "$lbl" 2>/dev/null
            if [ "$lbl_val" = "Tctl" ] || [ "$lbl_val" = "Package id 0" ]; then
                read -r raw_temp < "${lbl%_label}_input"
                ctemp=$(( raw_temp / 1000 ))
                break 2
            fi
        done
        if [ -r "$hw/temp1_input" ]; then
            read -r raw_temp < "$hw/temp1_input"
            ctemp=$(( raw_temp / 1000 ))
            break
        fi
    fi
done

if [ "$ctemp" = "--" ] && [ -r /sys/class/thermal/thermal_zone0/temp ]; then
    read -r raw_temp < /sys/class/thermal/thermal_zone0/temp
    ctemp=$(( raw_temp / 1000 ))
fi

while read -r key val _; do
    case "$key" in
        MemTotal:) mt=$val ;;
        MemAvailable:) ma=$val ;;
    esac
done < /proc/meminfo

mu=$((mt-ma))
rpct=$((100*mu/mt))

rused_scaled=$(( (mu * 10) / 1048576 ))
rused="$((rused_scaled / 10)).$((rused_scaled % 10))"
rtot=$(( (mt + 524288) / 1048576 ))

read -r dpct davail < <(df -BG --output=pcent,avail / 2>/dev/null | tail -1)
dpct=${dpct// /}; davail=${davail// /}; davail=${davail%G}

i1="${R}${clock}${X}"
i2="${DIM}${day_str} · up ${upt}${X}"
i3="${DIM}cpu  ${G}${cpu}%${DIM} · ${ctemp}°C${X}"
i4="${DIM}ram  ${T}${rused} ${DIM}/ ${rtot} GB · ${T}${rpct}%${X}"
i5="${S}Knowledge is your best friend.${X}"
i6="${S}                ~ パチュリー・ノーレッジ${X}"

printf '
⠀⠀%s
⠀⠀%s

⠀⠀%s
⠀⠀%s

⠀⠀%s
⠀⠀%s
' "$i1" "$i2" "$i3" "$i4" "$i5" "$i6"
