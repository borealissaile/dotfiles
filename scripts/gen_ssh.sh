#!/bin/sh

email="eliasfreitasbraga@gmail.com"
keyname="id_ed25519"

ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/$keyname -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$keyname
cat ~/.ssh/$keyname.pub
