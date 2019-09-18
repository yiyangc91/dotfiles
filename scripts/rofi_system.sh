# Menu with keys/commands
typeset -A menu
menu=(
  ["Shutdown\0icon\x1fsystem-shutdown-symbolic"]="systemctl poweroff"
  ["Reboot\0icon\x1fsystem-reboot-symbolic"]="systemctl reboot"
  ["Hibernate\0icon\x1fdrive-harddisk-symbolic"]="systemctl hibernate"
  ["Suspend\0icon\x1fprocess-stop-symbolic"]="systemctl suspend"
  ["Lock\0icon\x1fsystem-lock-screen-symbolic"]="xset s activate"
  ["Logout\0icon\x1fsystem-log-out-symbolic"]="i3-msg exit"
)

if [ -z $@ ]; then
   printf '%b\n' "${!menu[@]}" | sort
else
   selection=$@
   i3-msg -q "exec ${menu[${selection}]}"
fi
