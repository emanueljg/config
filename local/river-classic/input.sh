riverctl keyboard-layout \
  -variant 'altgr-intl' \
	-options 'caps:swapescape' \
  us

# Set keyboard repeat rate
riverctl set-repeat 35 200

riverctl set-cursor-warp on-focus-change
riverctl hide-cursor when-typing disabled
riverctl hide-cursor timeout 0

riverctl input \
  'pointer-1739-52990-SYNA2BA6:00_06CB:CEFE_Touchpad' \
  disable-while-typing disabled





