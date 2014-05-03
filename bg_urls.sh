#!/bin/bash

# TODO(noffle): Check for `wget` and `feh` being installed; bail if so.

# Toss these somewhere (hopefully) findable.
WALLPAPER_DIR=${HOME}/.8bitwallpapers
mkdir $WALLPAPER_DIR

# Grab wallpapers.
wget http://i.imgur.com/laSSeYN.png -O ${WALLPAPER_DIR}/bg_0.png
wget http://i.imgur.com/HaYuGQi.png -O ${WALLPAPER_DIR}/bg_1.png
wget http://i.imgur.com/NNoFNWf.png -O ${WALLPAPER_DIR}/bg_2.png
wget http://i.imgur.com/VW2DYbL.png -O ${WALLPAPER_DIR}/bg_3.png
wget http://i.imgur.com/UZKEjzG.png -O ${WALLPAPER_DIR}/bg_4.png
wget http://i.imgur.com/6EhAM7G.png -O ${WALLPAPER_DIR}/bg_5.png
wget http://i.imgur.com/QOfZ5r8.png -O ${WALLPAPER_DIR}/bg_6.png
wget http://i.imgur.com/Y4BHWJM.png -O ${WALLPAPER_DIR}/bg_7.png

# Generate a script to run periodically and update the background wallpaper.
UPDATE_SCRIPT=$WALLPAPER_DIR/update_bg.sh
cat << EOF > $UPDATE_SCRIPT
BG_INDEX=$(echo "$(date +%H) / 3" | bc)
feh --bg-scale ${WALLPAPER_DIR}/bg_${BG_INDEX}.png
EOF
chmod +x $UPDATE_SCRIPT

# Add logic to crontab (check hourly).
# TODO(noffle): It would be swell if, for laptops, this also ran upon waking up
# from suspend.
TEMP=$(mktemp)
crontab -l > $TEMP
echo "0 * * * * ${UPDATE_SCRIPT}" >> $TEMP
crontab $TEMP
rm $TEMP
