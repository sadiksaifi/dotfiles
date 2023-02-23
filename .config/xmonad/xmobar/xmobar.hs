Config { font            = "xft:Ubuntu:weight=bold:pixelsize=11:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki Nerd Font:pixelsize=11:antialias=true:hinting=true"
                           , "xft:Font Awesome 6 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 6 Brands:pixelsize=12"
                           ]
       , bgColor      = "#282c34"
       , fgColor      = "#ff6c6b"
       , position     = TopSize L 100 24
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
       , commands = [
                        -- Echos a "penguin" icon in front of the kernel output.
                      Run Com "echo" ["<fn=3>\xf17c</fn>"] "penguin" 3600

                        -- Get kernel version (script found in .local/bin)
                    , Run Com ".local/bin/kernel" [] "kernel" 36000

                        -- Cpu usage in percent
                    , Run Cpu ["-t", "<fn=2>\xf108</fn>  cpu: (<total>%)","-H","50","--high","red"] 20

                        -- Ram used number and percent
                    , Run Memory ["-t", "<fn=2>\xf233</fn>  mem: <used>M (<usedratio>%)"] 20

                        -- Disk space free
                    , Run DiskU [("/", "<fn=2>\xf0c7</fn>  hdd: <free> free")] [] 60

                        -- Echos an "up arrow" icon in front of the uptime output.
                    , Run Com "echo" ["<fn=2>\xf0aa</fn>"] "uparrow" 3600
                        -- Uptime
                    , Run Uptime ["-t", "uptime: <days>d <hours>h"] 360

                        -- Echos a "bell" icon in front of the pacman updates.
                    , Run Com "echo" ["<fn=2>\xf0f3</fn>"] "bell" 3600
                        -- Check for pacman updates (script found in .local/bin)
                    , Run Com ".local/bin/pacupdate" [] "pacupdate" 36000

                        -- Echos a "battery" icon in front of the pacman updates.
                    , Run Com "echo" ["<fn=2>\xf242</fn>"] "baticon" 3600
                        -- Battery
                    , Run BatteryP ["BAT1"] ["-t", "<acstatus> (<left>%)"] 360
                        -- Time and date

                    , Run Date "<fn=2>\xf017</fn>  %b %d %Y - (%H:%M) " "date" 50
                        -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
                    , Run Com ".config/xmonad/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                        -- Prints out the left side items such as workspaces, layout, etc.
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <action=`xdotool key Super_L+r`><icon=haskell.xpm/> </action><fc=#666666> |</fc> %UnsafeStdinReader% }{ <fc=#666666> | </fc> <fc=#51afef>%penguin%  %kernel%</fc> <fc=#666666> | </fc> <fc=#ecbe7b> <action=`alacritty -e htop`> %cpu% </action></fc> <fc=#666666> | </fc> <fc=#ff6c6b><action=`alacritty -e htop`> %memory% </action></fc> <fc=#666666> | </fc> <fc=#a9a1e1> %disku% </fc> <fc=#666666> | </fc> <fc=#98be65> %uparrow%  %uptime% </fc> <fc=#666666> | </fc><fc=#c678dd> %bell%  <action=`alacritty -e sudo pacman -Syu`> %pacupdate% </action></fc> <fc=#666666> | </fc><fc=#da8548> %baticon%  %battery% </fc> <fc=#666666> | </fc> <fc=#46d9ff><action=`emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(dt/year-calendar))'`> %date% </action></fc> <fc=#666666> |</fc>%trayerpad%"
       }
