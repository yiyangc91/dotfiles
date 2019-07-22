#!/bin/bash

ykman oath remember-password
exec ykman oath code -s "$@" | xclip -in -selection clipboard
