{ config, lib, ... }:

with lib;
{
  config = mkIf (config.ui.theme == "atmosphere") {
    ui.colorscheme.dark = with _.colors; {
      bg = ./dark/bg.jpg;
      lockBg = ./dark/lock.jpg;
      bar = {
        inactive = trueGray._500;
        normal = trueGray._50;
        notification = orange._500;
        batteryLow = orange._500;
        batteryCharging = emerald._500;
	tooltipBg = trueGray._900;
	tooltipFg = trueGray._50;
      };
      launcher = {
        bg = trueGray._700;
        searchBar = {
          bg = trueGray._600;
          fg = trueGray._50;
        };
        result = {
          normal = {
            bg = trueGray._700;
            fg = trueGray._200;
          };
          highlighted = {
            bg = trueGray._600;
            fg = trueGray._50;
          };
        };
        mode = {
          inactive = {
            bg = trueGray._700;
            fg = trueGray._200;
            border = trueGray._600;
          };
          active = {
            bg = trueGray._600;
            fg = trueGray._50;
            border = trueGray._600;
          };
        };
      };
      notification = {
        normal = {
          bg = trueGray._700;
          fg = trueGray._100;
        };
        critical = {
          bg = red._500;
          fg = red._50;
        };
      };
      sway = {
        tab = {
          separator = trueGray._600;
          inactive = {
            bg = trueGray._700;
            fg = trueGray._200;
          };
          active = {
            bg = trueGray._800;
            fg = trueGray._50;
          };
        };
      };
      terminal = {
        bg = trueGray._800;
        fg = trueGray._50;
        palette = {
          _0  = trueGray._700;
          _1  = red._400;
          _2  = emerald._400;
          _3  = yellow._400;
          _4  = blue._500;
          _5  = purple._500;
          _6  = cyan._300;
          _7  = trueGray._50;
          _8  = trueGray._700;
          _9  = red._400;
          _10 = emerald._400;
          _11 = yellow._400;
          _12 = blue._500;
          _13 = purple._500;
          _14 = cyan._300;
          _15 = trueGray._50;
        };
      };
    };

    ui.colorscheme.light = with _.colors; mkDefault {
      bg = ./light/bg.jpg;
      lockBg = ./light/lock.jpg;
      bar = {
        inactive = trueGray._300;
        normal = trueGray._50;
        notification = orange._400;
        batteryLow = orange._200;
        batteryCharging = emerald._200;
	tooltipBg = trueGray._50;
	tooltipFg = trueGray._800;
      };
      launcher = {
        bg = trueGray._200;
        searchBar = {
          bg = trueGray._300;
          fg = trueGray._800;
        };
        result = {
          normal = {
            bg = trueGray._200;
            fg = trueGray._700;
          };
          highlighted = {
            bg = trueGray._300;
            fg = trueGray._800;
          };
        };
        mode = {
          inactive = {
            bg = trueGray._200;
            fg = trueGray._700;
            border = trueGray._300;
          };
          active = {
            bg = trueGray._300;
            fg = trueGray._800;
            border = trueGray._300;
          };
        };
      };
      notification = {
        normal = {
          bg = trueGray._200;
          fg = trueGray._900;
        };
        critical = {
          bg = red._500;
          fg = red._50;
        };
      };
      sway = {
        tab = {
          separator = trueGray._200;
          inactive = {
            bg = trueGray._100;
            fg = trueGray._700;
          };
          active = {
            bg = trueGray._300;
            fg = trueGray._600;
          };
        };
      };
      terminal = {
        bg = trueGray._100;
        fg = trueGray._900;
        palette = {
          _0  = trueGray._900;
          _1  = red._500;
          _2  = emerald._500;
          _3  = yellow._500;
          _4  = blue._600;
          _5  = purple._600;
          _6  = cyan._400;
          _7  = trueGray._300;
          _8  = trueGray._900;
          _9  = red._500;
          _10 = emerald._500;
          _11 = yellow._500;
          _12 = blue._600;
          _13 = purple._600;
          _14 = cyan._400;
          _15 = trueGray._300;
        };
      };
    };
  };
}
