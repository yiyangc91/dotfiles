[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# completely shut off the monitor after 4 minutes
xset dpms 240 240 240
xset s 230 # this only serves to warn the user

/usr/bin/dunst &
/usr/bin/nm-applet &

xss-lock -n $HOME/bin/scripts/dim-screen.sh -- i3lock -n -c 000000 -i $HOME/.config/i3lock/wall.png &
exec /usr/bin/i3
