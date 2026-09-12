# My own Void Linux dotfiles

This is my git repo storing dotfiles handmade by me throughout using linux over time in
which in my opinion is the most minimal rice in my eyes.

I also like to script myself some of the desktop utils since i don't like downloading
extra packages, while at it i also make them easily readable and hackable so you can
change them whenever you want as you like.

> [!NOTE]
> Some config need to move to your $HOME or ~ directory like .bashrc, .bash_profile, .inputrc.
> Some of the config you need to change or replace by yourself if you are not using
> the same packages as mine (read the Dependency tree section below).

## Directory meaning

bash/  
all thing relate to bash like settings, custom aliases/functions, all file name
are end with .bash extension and source at ~/.bashrc file.

fastfetch/  
my own fastfetch config style for my system
(no you not gonna get these asset images on the left of fastfetch when this rice upload).

fcitx5/  
input method engine to help type different characters when i needed for multilingual person like me
(i may did insulted some monolingual like you).

fuzzel/  
dmenu like that is hackable, made by foot terminal creator.

git/  
my own git config (do change the email and ssh key location on your system).

i3bar-river/ + i3status-rust/  
they compliment with each other to make up the bar.

kitty/  
config for the kitty terminal (best terminal in my opinion and can be like tmux).

mako/  
style your notification info pop up.

niri/  
rust scrolling tiling window manager (the scrolling is peak on laptop)
and the update cycle is better than hyprland breaking your system.

nvim/  
neovim > vscode do i need to say more?.

old_rice/  
legacy rice from oldware i have used like waybar (eww gtk), or old fastfetch config that i like, 
just rename them and move to their folder to use them.

scripts/  
shell scripts as desktop replacement that i made for myself.

swaylock/ + wlogout/  
one is for styling session lock, another is for styling logout menu for when using keybind.

xdg-desktop-portal/  
setting default niri to use firefox file picker and screen cast portals.

## Packages using

Download them using your own packages manager by yourself!.

Bare minimal usable:
```fuzzel i3bar-river i3status-rust kitty neovim niri```

Full set up:
```
brightnessctl fastfetch fuzzel i3bar-river i3status-rust \
kitty mako neovim niri starship swaybg swayidle swaylock wlogout
```

## Dependency tree

```
.config/niri/startup.kdl
|\.config/scripts/wayland_start.sh
|  |\libnotify
|  |\swaybg
|  |\swayidle
|  | \swaylock
|  |  \loginctl
|   \pipewire
|    \i3bar-river
|     \i3status-rust
 \.config/scripts/battery_monitor.sh
  \libnotify

.config/niri/bind_custom.kdl
|\kitty
|\fuzzel
|\swaylock
|\wpctl
|\playerctl
|\brightnessctl
|
|\kitty
| \bc
|\wlogout
|\.config/scripts/bg_picker_fuzzel.sh
|  |\fuzzel
|  |\swaybg
|  |\libnotify
 \wl-copy

.config/starship.toml
 \.config/scripts/starship_char.sh
```

## My neovim folders

```
init.lua

lsp:
|- bash_lang.lua
|- lua_lang.lua
|- rust_lang.lua


lua:
|- config/
|- core/
|- plugins/

lua/config:
|- autocmds.lua
|- keymaps.lua
|- options.lua

lua/core:
|- lazy.lua
|- lsp.lua
|- stline.lua

lua/plugins:
|- blink.lua
|- colorscheme.lua
|- gitsigns.lua
|- snacks.lua
```
