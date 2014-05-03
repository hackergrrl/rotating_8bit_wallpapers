#!/bin/bash

# TODO(noffle): Check for `wget` and `feh` being installed; bail if so.

# Toss these somewhere (hopefully) findable.
WALLPAPER_DIR=${HOME}/.8bitwallpapers
mkdir $WALLPAPER_DIR

# Grab wallpapers.
REPO_URL=https://github.com/noffle/rotating_8bit_wallpapers/raw/master
for i in {0..7}; do
    wget $REPO_URL/bg_${i}.png -O ${WALLPAPER_DIR}/bg_${i}.png
done

# Generate a script to run periodically and update the background wallpaper.
UPDATE_SCRIPT=$WALLPAPER_DIR/update_bg.sh
cat << EOF > $UPDATE_SCRIPT
BG_INDEX=\$(echo "\$(date +%H) / 3" | bc)
feh --bg-scale ${WALLPAPER_DIR}/bg_\${BG_INDEX}.png
EOF
chmod +x $UPDATE_SCRIPT

# Add logic to crontab (check hourly).
# TODO(noffle): It would be swell if, for laptops, this also ran upon waking up
# from suspend.
TEMP=$(mktemp)
crontab -l > $TEMP
echo "1 * * * * ${UPDATE_SCRIPT}" >> $TEMP
crontab $TEMP
rm $TEMP

# Initial run.
sh ${UPDATE_SCRIPT}
