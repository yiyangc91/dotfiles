#!/bin/bash

sed -i 's/^fade:.*/fade: False/' $HOME/.xscreensaver && xscreensaver-command -lock

# set the fade timer back after a short sleep
# this is important because the config reloading doesnt work otherwise
sleep 1
sed -i 's/^fade:.*$/fade: True/' $HOME/.xscreensaver
