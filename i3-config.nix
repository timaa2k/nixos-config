{ dmenu, i3status }:

''
## i3 config file (v4)
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, if you need a lot of unicode glyphs or
# right-to-left text rendering, you should instead use pango for rendering and
# chose a FreeType font, such as:
# font pango:DejaVu Sans Mono 10

## i3 Settings

# Font

#font pango:Cantarell 12 
#font pango:Menlo for Powerline Bold 10
font pango:Droid Sans Bold 10 

# Windows

popup_during_fullscreen smart
hide_edge_borders smart
force_focus_wrapping yes
workspace_auto_back_and_forth yes
new_window pixel 1
new_float pixel 1

# Theme

client.focused          #121212 #101010 #9e8a8e
client.focused_inactive #101010 #191919 #999999
client.unfocused        #101010 #191919 #999999
client.urgent           #cd989a #cd989a #2e3436
client.background       #1d1d1d
#client.background #4d4d4d

# DPI settings

exec_always --no-startup-id xrandr --dpi 144

# Key repeat settings

exec --no-startup-id xset r rate 150 25

# Gnome 

exec --no-startup-id /usr/lib/gnome-settings-daemon/gsd-xsettings
exec_always --no-startup-id gnome-power-manager

# Wallpaper

exec_always --no-startup-id feh --bg-fill $HOME/.config/i3/wallpaper

# Autostart

exec $HOME/.config/i3/autostart

# use Mouse+Mod1 to drag floating windows to their wanted position

floating_modifier Mod1

# Defined Keybindings
bindsym Mod1+Return exec --no-startup-id alacritty
bindsym Mod1+d exec --no-startup-id alacritty -e ranger
bindsym Mod1+s exec --no-startup-id alacritty -e alsamixer
bindsym Mod1+b exec chromium-browser -incognito --force-device-scale-factor=1.1
bindsym Mod1+p exec j4-dmenu-desktop --dmenu="dmenu -i -l 20 -fn 'Droid Sans-12:style=bold'" --term="alacritty"
bindsym Mod1+Shift+p exec dmenu_run -i -l 20 -fn "Droid Sans-12:style=bold"
bindsym Mod1+u exec pavucontrol &
bindsym Mod1+Tab exec quickswitch.py --dmenu="dmenu -i -l 20 -fn 'Droid Sans-12:style=bold'"

bindsym Print exec $HOME/bin/screenshot root
bindsym Mod1+Print exec $HOME/bin/screenshot active

# ctags rebuild in project folder
bindsym Mod1+Shift+t exec ctags -R -f ./.git/tags .

# kill focused window
bindsym Mod1+Shift+q kill

# alternatively, you can use the cursor keys:
bindsym Mod1+h focus left
bindsym Mod1+j focus down
bindsym Mod1+k focus up
bindsym Mod1+l focus right

# alternatively, you can use the cursor keys:
#bindsym Control+h exec --no-startup-id tmux_sys_win_aware_navigation.sh left
#bindsym Control+j exec --no-startup-id tmux_sys_win_aware_navigation.sh down
#bindsym Control+k exec --no-startup-id tmux_sys_win_aware_navigation.sh up
#bindsym Control+l exec --no-startup-id tmux_sys_win_aware_navigation.sh right

# vim keys:
bindsym Mod1+Shift+h move left
bindsym Mod1+Shift+j move down
bindsym Mod1+Shift+k move up
bindsym Mod1+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym Mod1+Left workspace prev
bindsym Mod1+Down workspace next
bindsym Mod1+Up workspace prev
bindsym Mod1+Right workspace next

# alternatively, you can use the cursor keys:
bindsym Mod1+Shift+Left move left
bindsym Mod1+Shift+Down move down
bindsym Mod1+Shift+Up move up
bindsym Mod1+Shift+Right move right

# split in horizontal orientation
bindsym Mod1+v split v

# split in vertical orientation
bindsym Mod1+g split h

# enter fullscreen mode for the focused container
bindsym Mod1+f fullscreen

# change container layout (stacked, tabbed, toggle split)
#bindsym Mod1+s layout stacking
#bindsym Mod1+w layout tabbed
bindsym Mod1+e layout toggle split
bindsym Mod1+w exec i3-dtags.sh
bindsym Mod1+Shift+w exec i3-dtags-moveto.sh

# Make the currently focused window a scratchpad
#bindsym Mod1+a move scratchpad
# Show the first scratchpad window
#bindsym Mod1+s scratchpad show

# Show the sup-mail scratchpad window, if any.
# bindsym mod4+s [title="^Sup ::"] scratchpad show


# toggle tiling / floating
bindsym Mod1+t floating toggle

# focus the parent container
#bindsym Mod1+a focus parent

# focus the child container
#bindsym Mod1+d focus child

# switch to workspace

bindcode Mod1+49 workspace number 0
bindsym Mod1+1 workspace number 1
bindsym Mod1+2 workspace number 2
bindsym Mod1+3 workspace number 3
bindsym Mod1+4 workspace number 4
bindsym Mod1+5 workspace number 5
bindsym Mod1+6 workspace number 6
bindsym Mod1+7 workspace number 7
bindsym Mod1+8 workspace number 8
bindsym Mod1+9 workspace number 9

# move focused container to workspace
bindcode Mod1+Shift+49 move container to workspace number 0
bindsym Mod1+Shift+1 move container to workspace number 1
bindsym Mod1+Shift+2 move container to workspace number 2
bindsym Mod1+Shift+3 move container to workspace number 3
bindsym Mod1+Shift+4 move container to workspace number 4
bindsym Mod1+Shift+5 move container to workspace number 5
bindsym Mod1+Shift+6 move container to workspace number 6
bindsym Mod1+Shift+7 move container to workspace number 7
bindsym Mod1+Shift+8 move container to workspace number 8
bindsym Mod1+Shift+9 move container to workspace number 9

# reload the configuration file
bindsym Mod1+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym Mod1+Shift+r restart


# exit i3 (logs you out of your X session)
#bindsym Mod1+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h           resize shrink width 10 px or 10 ppt
        bindsym j           resize grow height 10 px or 10 ppt
        bindsym k           resize shrink height 10 px or 10 ppt
        bindsym l           resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left        resize shrink width 10 px or 10 ppt
        bindsym Down        resize grow height 10 px or 10 ppt
        bindsym Up          resize shrink height 10 px or 10 ppt
        bindsym Right       resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}
bindsym Mod1+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)

bar {
    status_command i3blocks -c $HOME/.config/i3/i3blocks.conf
    mode dock
    position top
    workspace_buttons yes
    #strip_workspace_numbers yes
    colors {
        background #101010
        statusline #364150
    }
}

# Application Settings
for_window [class="Chromium"] border none
for_window [class="Java" instance="^java$"] border none; floating enable
for_window [class="Pavucontrol"] border none
for_window [class="Evince"] border none


for_window [class="URxvt" instance="^urxvt$"] border none
for_window [class="Skype" instance="^skype$"] border none
for_window [class="java-lang-Thread" instance="^sun-awt-X11-XFramePeer$"] border none; floating enable


set $mode_system SYSTEM lock, exit, suspend, hibernate, reboot
mode "$mode_system" {
    bindsym l exec --no-startup-id $HOME/.config/i3/i3exit lock, mode "default"
    bindsym e exec --no-startup-id $HOME/.config/i3/i3exit logout, mode "default"
    bindsym s exec --no-startup-id $HOME/.config/i3/i3exit suspend, mode "default"
    bindsym h exec --no-startup-id $HOME/.config/i3/i3exit hibernate, mode "default"
    bindsym r exec --no-startup-id $HOME/.config/i3/i3exit reboot, mode "default"
    bindsym c exec --no-startup-id $HOME/.config/i3/i3exit switchuser, mode "default"
    bindsym Shift+s exec --no-startup-id $HOME/.config/i3/i3exit shutdown, mode "default"
    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym Mod1+x mode "$mode_system"


# Enable function keys

bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute 1 toggle

bindsym XF86MonBrightnessUp exec xbacklight -inc 10
bindsym XF86MonBrightnessDown exec xbacklight -dec 10

# bindsym XF86PowerOff exec ~/.i3/i3exit lock
#bindsym XF86WLAN exec chromium
#bindsym XF86Launch2 exec chromium
#python2 ~/.i3/tabletMode.py
#bindsym Mod1+c exec touchpad
#bindcode 56 exec

# vim:filetype=i3
''
