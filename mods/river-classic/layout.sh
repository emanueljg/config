# Super+Q to close the focused view
riverctl map normal Alt+Shift Q close

# Super+J and Super+K to focus the next/previous view in the layout stack
riverctl map normal Alt J focus-view next
riverctl map normal Alt K focus-view previous

# Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
# view in the layout stack
riverctl map normal Alt+Shift J swap next
riverctl map normal Alt+Shift K swap previous

# Super+Period and Super+Comma to focus the next/previous output
riverctl map normal Alt Period focus-output next
riverctl map normal Alt Comma focus-output previous

# Super+Shift+{Period,Comma} to send the focused view to the next/previous output
riverctl map normal Alt+Shift Period send-to-output next
riverctl map normal Alt+Shift Comma send-to-output previous

# Super+Return to bump the focused view to the top of the layout stack
riverctl map normal Alt Return zoom

# Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
riverctl map normal Alt H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal Alt L send-layout-cmd rivertile "main-ratio +0.05"

# Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
riverctl map normal Alt+Shift H send-layout-cmd rivertile "main-count +1"
riverctl map normal Alt+Shift L send-layout-cmd rivertile "main-count -1"

for i in $(seq 1 9)
do
    tags=$((1 << (i - 1)))

    # Super+[1-9] to focus tag [0-8]
    riverctl map normal Alt "$i" set-focused-tags $tags

    # Super+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Alt+Shift "$i" set-view-tags $tags

    # Super+Control+[1-9] to toggle focus of tag [0-8]
    riverctl map normal Alt+Control "$i" toggle-focused-tags $tags

    # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal Alt+Shift+Control "$i" toggle-view-tags $tags
done

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal Alt 0 set-focused-tags $all_tags
riverctl map normal Alt+Shift 0 set-view-tags $all_tags

riverctl send-layout-cmd rivertile "main-ratio 0.53"



# Super+F to toggle fullscreen
riverctl map normal Alt F toggle-fullscreen

# Super+{Up,Right,Down,Left} to change layout orientation
riverctl map normal Alt Up    send-layout-cmd rivertile "main-location top"
riverctl map normal Alt Right send-layout-cmd rivertile "main-location right"
riverctl map normal Alt Down  send-layout-cmd rivertile "main-location bottom"
riverctl map normal Alt Left  send-layout-cmd rivertile "main-location left"

# Make all views with app-id "bar" and any title use client-side decorations
riverctl rule-add -app-id "bar" csd

# Set the default layout generator to be rivertile and start it.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile

rivertile -view-padding 6 -outer-padding 6 &

