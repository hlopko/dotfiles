#!/bin/bash

gnome-screensaver-command --lock
dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend
