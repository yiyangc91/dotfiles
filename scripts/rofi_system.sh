# Menu with keys/commands
typeset -A menu icons
menu=(
  [Shutdown]="systemctl poweroff"
  [Reboot]="systemctl reboot"
  [Hibernate]="systemctl hibernate"
  [Suspend]="systemctl suspend"
  [Lock]="xset s activate"
  [Monitor Setup]="rofi -modi monitor:$HOME/bin/scripts/rofi_monitor_layout.sh -show monitor -p 'Monitor Setup:'"
)
icons=(
  [Shutdown]="system-shutdown-symbolic"
  [Reboot]="system-reboot-symbolic"
  [Hibernate]="drive-harddisk-symbolic"
  [Suspend]="process-stop-symbolic"
  [Lock]="system-lock-screen-symbolic"
  [Monitor Setup]="video-display-symbolic"
)

if [ -z $@ ]; then
   for k in "${!menu[@]}"; do
      echo -e "$k\0icon\x1f${icons[${k}]}"
   done
else
   selection=$@
   ${menu[${selection}]}
fi
