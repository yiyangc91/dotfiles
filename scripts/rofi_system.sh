# Menu with keys/commands
typeset -A menu icons
menu=(
  [Shutdown]="systemctl poweroff"
  [Reboot]="systemctl reboot"
  [Hibernate]="systemctl hibernate"
  [Suspend]="systemctl suspend"
  [Lock]="xset s activate"
  [Logout]="i3-msg exit"
)
icons=(
  [Shutdown]="\0icon\x1fsystem-shutdown-symbolic"
  [Reboot]="\0icon\x1fsystem-reboot-symbolic"
  [Hibernate]="\0icon\x1fdrive-harddisk-symbolic"
  [Suspend]="\0icon\x1fprocess-stop-symbolic"
  [Lock]="\0icon\x1fsystem-lock-screen-symbolic"
  [Logout]="\0icon\x1fsystem-log-out-symbolic"
)

if [ -z $@ ]; then
   for k in "${!menu[@]}"; do
      echo -e "$k${icons[${k}]}"
   done
else
   selection=$@
   i3-msg -q "exec ${menu[${selection}]}"
fi
