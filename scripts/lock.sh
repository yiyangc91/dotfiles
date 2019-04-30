#!/bin/bash

sed -i 's/^fade:.*/fade: False/' $HOME/.xscreensaver && xscreensaver-command -lock && sed -i 's/^fade:.*$/fade: True/' $HOME/.xscreensaver
