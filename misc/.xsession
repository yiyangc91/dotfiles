[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
/usr/bin/dunst &
/usr/bin/nm-applet &
xss-lock -- i3lock -n -c 000000 -i $HOME/.config/i3lock/wall.png &
exec /usr/bin/i3
