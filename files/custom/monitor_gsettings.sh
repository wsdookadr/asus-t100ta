#!/bin/bash
#
# Monitors lock/unlock events and restores Gnome/Phosh settings accordingly.
# 
# Profiles:
# - regular_usage
# - extended_reading
#
gdbus monitor -y -d org.freedesktop.login1 | \
while read LINE; do
	if [[    "$LINE" =~ ^.*org.freedesktop.login1.Seat.*IdleHint.*true.*$ ]]; then
		# tabled was locked, it's now idling
		echo "Idle!\n"
	elif [[  "$LINE" =~ ^.*org.freedesktop.login1.Seat.*IdleHint.*false.*$ ]]; then
		# tablet was unlocked/resumed, it's ready for use
		echo "Resumed!\n"
		sleep 0.3
		PROFILE=$(cat /custom/current_profile.txt)
		/custom/profile_$PROFILE.sh
	fi
done

