{ config, lib, pkgs, ... }:

with lib;
{
  config.programs.neovim = {
    enable = true;
    vimAlias = true;
    configure = {
      customRC = ''
      lua require('impatient')
      lua << EOF
      ${pkgs.lib.readFile ./init.lua}
      EOF
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          impatient-nvim # speed up loading Lua modules in Neovim
          vim-vinegar # better netrw
          vim-commentary # easier commenting
          (nvim-treesitter.withPlugins (plugins: with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-clojure
            tree-sitter-fennel
            tree-sitter-haskell
            tree-sitter-json
            tree-sitter-lua
            tree-sitter-markdown
            tree-sitter-nix
	    tree-sitter-python
            tree-sitter-typescript
            tree-sitter-yaml
          ]))
	  nvim-lspconfig
        ];
	opt = [];
      };
    };
  };
}
