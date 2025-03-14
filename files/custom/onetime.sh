#!/bin/bash
sleep 2
PROFILE=$(cat /custom/current_profile.txt)
/custom/profile_$PROFILE.sh
