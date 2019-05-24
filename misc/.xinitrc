[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# does something. copied from arch.
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# completely shut off the monitor and lock screen after 4 minutes
# this is staggered - turns out if the cycle ends and dpms starts, xss-lock
# sees that it's already running the notifier and doesn't lock the screen,
# but the cycle never triggers to lock the screen because the screen is off...
xset dpms 240 240 240
xset s 230 5

# remap caps-lock because nobody needs it
compton -b
setxkbmap -option caps:super

dunst &
nm-applet &
parcellite &

# xss-lock -n $HOME/bin/scripts/dim-screen.sh -- i3lock -n -c 000000 -i $HOME/.config/i3lock/wall.png &
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- $HOME/bin/scripts/lock.sh &

exec /usr/bin/i3
