#!/bin/sh

if [ -z "$1" ]; then
    selected=$(zenity --file-selection --title="Escolher Wallpaper" --file-filter="*.png *.jpg *.jpeg *.webp *.bmp *.gif")
    [ -z "$selected" ] && exit 1
else
    selected="$1"
fi

cp "$selected" ~/.config/background

awww img --transition-fps=180 --transition-type=grow --transition-pos=center --transition-duration=1 ~/.config/background
