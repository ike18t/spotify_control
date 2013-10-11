#!/bin/sh
nohup bundle exec thin start -p 4567 -R config.ru > ~/spotify_control.log 2>&1 &
