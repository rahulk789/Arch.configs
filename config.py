import os
import re
import socket
import subprocess
from libqtile.command import lazy
from libqtile import qtile
from typing import List  # noqa: F401
from libqtile import bar, layout, widget ,hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


mod = "mod4"
terminal = guess_terminal()

keys = [

    # Switch between window

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
   
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
   
    Key([mod, "control"], "h", lazy.layout.grow_left(),desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control", "shift"], "r", lazy.spawn(" reboot"), desc="Restart sys"),
    Key([mod, "control", "shift"], "s", lazy.spawn(" systemctl suspend"), desc="Suspend sys"),
    Key([mod, "control", "shift"], "q", lazy.spawn(" shutdown now"), desc="Shutdown sys"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
#   Key([mod], "z", lazy.spawn(" network.sh"), desc="wifi applet"), 
#   Key([mod], "a", lazy.spawn(" rofi -show drun"), desc="Spawn rofi"),
    Key([mod], "n", lazy.spawn(" chromium"), desc="Spawn chromium"),
]

'''groups = [Group("MUS", layout='monadtall'),
          Group("WWW", layout='monadtall'),
          Group("DIS", layout='monadtall'),
          Group("DEV", layout='monadtall'),
          Group("DOC", layout='monadtall'),
          Group("VBOX", layout='monadtall'),
          Group("SYS", layout='monadtall'),
          Group("MUS", layout='monadtall'),
          Group("VID", layout='monadtall'),
          Group("GFX", layout='floating')]
          from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")
'''
groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])



layouts = [
    layout.Columns(border_focus='#808080',border_normal='000000', border_width=2, margin=2),
    #layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=2, margin=8),
     layout.Max(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Source Code Pro',
    fontsize=12,
    padding=3,
    fontcolor='ebdbb2'
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.Spacer(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                 widget.Sep(linewidth=5),
                 widget.Clock(),
                 widget.HDDBusyGraph(border_color='808080',graph_color='cc231c',fill_color='fb4833'),
                 widget.PulseVolume(),
                 widget.Sep(linewidth=5),
                 widget.NvidiaSensors(),
                 widget.Sep(linewidth=5),
                 widget.Net(interface='wlo1',format=' Wifi: {down}↓↑{up} '),
                 # widget.Wlan(interface='wlo1',format='{percent:2.0%}'),
                 widget.NetGraph(border_color='808080',graph_color='cc231c',fill_color='fb4833'),
                 widget.Sep(linewidth=5),                                                
                 widget.Systray(),
                
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
],border_focus='#8080803',border_normal='#000000')
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = False

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# java that happens to be on java's whitelist.
wmname = "LG3D"
