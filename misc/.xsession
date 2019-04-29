[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# completely shut off the monitor and lock screen after 4 minutes
# this is staggered - turns out if the cycle ends and dpms starts, xss-lock
# sees that it's already running the notifier and doesn't lock the screen,
# but the cycle never triggers to lock the screen because the screen is off...
xset dpms 240 240 240
xset s 220 15

/usr/bin/dunst &
/usr/bin/nm-applet &

xss-lock -n $HOME/bin/scripts/dim-screen.sh -- i3lock -n -c 000000 -i $HOME/.config/i3lock/wall.png &
exec /usr/bin/i3
