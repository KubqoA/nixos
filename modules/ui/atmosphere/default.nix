#        _                             _                   
#   __ _| |_ _ __ ___   ___  ___ _ __ | |__   ___ _ __ ___ 
#  / _` | __| '_ ` _ \ / _ \/ __| '_ \| '_ \ / _ \ '__/ _ \
# | (_| | |_| | | | | | (_) \__ \ |_) | | | |  __/ | |  __/
#  \__,_|\__|_| |_| |_|\___/|___/ .__/|_| |_|\___|_|  \___|
#                               |_|                        
#
# Atmosphere UI:
# * WM: Sway
# * Terminal: Foot
# * Bar: Waybar
# * Font: Inter / JetBrains Mono
# Other utils:
# 

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.ui.theme == "atmosphere") (let
    # TODO: Work on the light/dark mode switch
    colorscheme = config.ui.colorscheme.light;
  in {
    hm.home.packages = with pkgs; [
      (pass.withExtensions (exts: with exts; [exts.pass-otp exts.pass-genphrase]))
      grim slurp libnotify
      firefox-wayland
      wl-clipboard
      swayidle swaylock bemenu
    ];

    # Terminal
    hm.programs.foot = {
      enable = true;
      settings = {
        main = {
	  pad = "20x20";
	  font = "monospace:size=8";
	  line-height = 11;
	  bold-text-in-bright = "yes";
	};
	colors = {
	  alpha = 1;
	  foreground = colorscheme.terminal.fg;
	  background = colorscheme.terminal.bg;
	  regular0 = colorscheme.terminal.palette._0;
	  regular1 = colorscheme.terminal.palette._1;
	  regular2 = colorscheme.terminal.palette._2;
	  regular3 = colorscheme.terminal.palette._3;
	  regular4 = colorscheme.terminal.palette._4;
	  regular5 = colorscheme.terminal.palette._5;
	  regular6 = colorscheme.terminal.palette._6;
	  regular7 = colorscheme.terminal.palette._7;
	  bright0  = colorscheme.terminal.palette._8;
	  bright1  = colorscheme.terminal.palette._9;
	  bright2  = colorscheme.terminal.palette._10;
	  bright3  = colorscheme.terminal.palette._11;
	  bright4  = colorscheme.terminal.palette._12;
	  bright5  = colorscheme.terminal.palette._13;
	  bright6  = colorscheme.terminal.palette._14;
	  bright7  = colorscheme.terminal.palette._15;
	};
      };
    };

    # UI
    # Kanshi
    hm.services.kanshi = {
      enable = true;
      profiles.default.outputs = [{
        criteria = "eDP-1";
        mode = "1920x1080";
        position = "0,0";
      }];
      profiles.work.outputs = [
        {
          criteria = "DP-1";
          mode = "2560x1440";
          position = "0,0";
        }
        {
          criteria = "eDP-1";
          mode = "1920x1080";
          position = "320,1440";
        }
      ];
    };
  
    # Notifications
    hm.programs.mako = {
      enable = true;
      anchor = "bottom-right";
      layer = "overlay";
      font = "Inter 12";
      format = "<span font_family=\"MADE Outer Sans\" font_weight=\"500\" line_height=\"1.4\">%s</span>\n%b";
      padding = "14,14";
      margin = "10,10,0,0";
      backgroundColor = "#${colorscheme.notification.normal.bg}";
      textColor = "#${colorscheme.notification.normal.fg}";
      borderRadius = 4;
      borderSize = 0;
      defaultTimeout = 10000;
      extraConfig = ''
        [urgency=high]
        ignore-timeout=1
        background-color=#${colorscheme.notification.critical.bg}
        text-color=#${colorscheme.notification.critical.fg}
      '';
    };
  
    # Night mode
    hm.services.wlsunset = {
      enable = true;
      latitude = "48.9";
      longitude = "18.0";
      temperature.night = 4500;
    };
  
    # Waybar
    hm.programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = ["sway/workspaces" "sway/mode" "sway/language" "clock" "battery" "network" "mpris"];
        modules-center = [];
        modules-right = [];
        "sway/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
             "1" = "";
             "2" = "";
             "3" = "";
             "4" = "";
             "5" = "";
             "6" = "";
             "7" = "";
             "8" = "";
          };
          sort-by-number = true;
        };
        "sway/language" = {
          format = "{short} {variant}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
          tooltip = false;
        };
        clock = {
          format = "{:%a %d %B, %H:%M}";
          format-alt = "{:%H:%M}";
        };
        battery = {
          states = {
            warning = 20;
          };
          format = "{capacity}%";
          format-charging = "{capacity}%";
          format-warning = "{capacity}%";
        };
        network = {
          interface = "wlan0";
          format-icons = [ "" "" "" "" ];
          format = "";
          format-wifi = "{icon}";
          format-ethernet = "ethernet";
          format-disconnected = "no internet";
          tooltip-format = "";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "";
          tooltip-format-disconnected = "Disconnected";
          max-length = 5;
        };
      };

      style = ''
* {
  border: none;
  border-radius: 0;
  font-family: icomoon, "MADE Outer Sans", Inter, sans-serif;
  font-weight: 300;
  min-height: 0;
  padding: 0;
  margin: 0;
}

window#waybar {
  background: none;
}

tooltip {
  background: #${colorscheme.bar.tooltipBg};
  border-radius: 4px;
  border: none;
}

tooltip label {
  font-size: 13px;
  padding: 2px 5px;
  color: #${colorscheme.bar.tooltipFg};
}

#mode, #language, #clock, #battery, #network, #mpris {
  padding: 5px;
  margin-right: 10px;
  margin-bottom: 10px;
  font-size: 13px;
  color: #${colorscheme.bar.normal};
}

#workspaces {
  margin-left: 10px;
  margin-bottom: 10px;
}

#workspaces button {
  margin-right: 15px;
  font-size: 18px;
  background: transparent;
  color: #${colorscheme.bar.inactive};
}

#workspaces button.focused {
  color: #${colorscheme.bar.normal};
}

#workspaces button.urgent {
  color: #${colorscheme.bar.notification};
}

#workspaces button:hover {
  box-shadow: inherit;
  text-shadow: inherit;
  color: #${colorscheme.bar.normal};
}

#battery.warning {
  color: #${colorscheme.bar.batteryLow};
}

#battery.charging {
  color: #${colorscheme.bar.batteryCharging};
}

#network.wifi {
  font-size: 18px;
  padding: 0;
}

#network.disconnected {
  color: #${colorscheme.bar.inactive};
}
      '';
    };
  
    # Sway
    security.polkit.enable = true;
    security.pam.services.swaylock = {};
    hardware.opengl.enable = lib.mkDefault true;
    fonts.enableDefaultFonts = lib.mkDefault true;
    programs.dconf.enable = lib.mkDefault true;
    # To make a Sway session available if a display manager like SDDM is enabled:
    #services.xserver.displayManager.sessionPackages = [ swayPackage ];
    programs.xwayland.enable = lib.mkDefault true;
    # For screen sharing (this option only has an effect with xdg.portal.enable):
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];

    hm.wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = {
        assigns = let
          assign = n: id: { "${toString n}" = [id]; };
        in
          assign 4 { class = "Spotify"; } //
          assign 9 { app_id = "zoom"; } //
          assign 10 { class = "Slack"; };
        bars = [{ command = "waybar"; position = "bottom"; }];
        fonts = {
          names = [ "MADE Outer Sans" "Inter" ];
          size = 12.0;
        };
        gaps.inner = 10;
        input."type:keyboard" = {
          xkb_layout = "us,us,sk";
          xkb_variant = ",colemak_dh,qwerty";
          xkb_options = "grp:alt_shift_toggle";
          xkb_numlock = "enabled";
        };
        input."type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_method = "two_finger";
        };
        keybindings = let
          mod = "Mod4";
          processScreenshot = ''wl-copy -t image/png && notify-send "Screenshot taken"'';
        in lib.mkOptionDefault {
          # Lock
          "Mod1+l" = "exec lock";
          ## Control volume
          #XF86AudioRaiseVolume = mkIf audioSupport "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          #XF86AudioLowerVolume = mkIf audioSupport "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          #XF86AudioMute = mkIf audioSupport "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          #XF86AudioMicMute = mkIf audioSupport "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          ## Control media
          #XF86AudioPlay = mkIf audioSupport "exec playerctl play-pause";
          #XF86AudioPause = mkIf audioSupport "exec playerctl play-pause";
          #XF86AudioNext = mkIf audioSupport "exec playerctl next";
          #XF86AudioPrev = mkIf audioSupport "exec playerctl previous";
          # Control brightness
          XF86MonBrightnessUp = "exec light -A 10";
          XF86MonBrightnessDown = "exec light -U 10";
          # Screenshot
          "${mod}+Print" = ''exec grim - | ${processScreenshot}'';
          "${mod}+Shift+Print" = ''exec grim -g "$(slurp -d)" - | ${processScreenshot}'';
          # Workspace 10
          "${mod}+0" = "workspace 10";
          "${mod}+Shift+0" = "move container to workspace 10";
          # Shortcuts for easier navigation between workspaces
          "${mod}+Control+Left" = "workspace prev";
          "${mod}+Control+l" = "workspace prev";
          "${mod}+Control+Right" = "workspace next";
          "${mod}+Control+h" = "workspace next";
          "${mod}+Tab" = "workspace back_and_forth";
          # Exit sway
          #"${mod}+Shift+e" = "exec nwgbar -o 0.2";
        };
        menu = "bemenu-run -b";
        modifier = "Mod4";
        output."*" = { bg = "${colorscheme.bg} fill"; };
        terminal = "foot";
        window.border = 0;
        window.commands = let
          rule = command: criteria: { command = command; criteria = criteria; };
        in [
          (rule "floating enable, sticky enable, resize set 384 216, move position 1516 821" { app_id = "firefox"; title = "^Picture-in-Picture$"; })
        ];
      };
      extraConfig = ''
# Import the most important environment variables into the D-Bus and systemd
# user environments (e.g. required for screen sharing and Pinentry prompts):
exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP

client.focused ${colorscheme.sway.tab.active.bg} ${colorscheme.sway.tab.active.bg} ${colorscheme.sway.tab.active.fg}
client.unfocused ${colorscheme.sway.tab.separator} ${colorscheme.sway.tab.inactive.bg} ${colorscheme.sway.tab.inactive.fg}

bindgesture swipe:right workspace prev
bindgesture swipe:left workspace next

workspace 1
      '';
    };
  });
}
