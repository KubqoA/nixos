{ lib, ... }:

with lib;
{
  options = with types; {
    ui.theme = _.mkOpt str "atmosphere" "Theme defines the look of the OS";
    ui.colorscheme = _.mkOpt attrs {} "Colorscheme defines the colors and background for the chosen theme";
  };
}
