{ config, lib, pkgs, ... }:

with lib;
{
  options = with types; {
    shell.zsh.enable = mkEnableOption "darling erasure";
  };

  config = mkIf config.shell.zsh.enable {
    programs.zsh.enable = true;
    user.shell = pkgs.zsh;
    hm.xdg.configFile."art".source = ./art;
    hm.programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        windows = "doas efibootmgr -n 0000 && reboot";
        lreboot = "doas efibootmgr -n 0001 && reboot";
        sysu = "systemctl --user";
        ls = "ls --color=auto -F";
        chx = "chmod +x";
        # ssh = "TERM=xterm-256color ssh";
        dots = "nvim /persist/etc/nixos";
      
        # git
        gad = "git add .";
        gc = "git commit";
        gcan = "git commit --amend --no-edit";
        gcaan = "git commit --amend -a --no-edit";
        gri = "git rebase --interactive";
        grc = "git rebase --continue";
        gra = "git rebase --abort";
	gprd = "git pull origin develop --rebase";
        gprm = "git pull origin master --rebase";
        gpr = "git pull origin main --rebase";
        gp = "git push";
        gfp = "git push --force";
        gdf = "git diff HEAD .";
        gs = "git stash";
        gsp = "git stash pop";
        
        # nix
        newos = "doas nixos-rebuild switch";
        upgradeos = "cd /persist/etc/nixos && nix flake update && doas nixos-rebuild switch";
        nixgc = "doas nix-collect-garbage -d";
      };
      autocd = true;
      dotDir = ".config/zsh";
      history = {
        path = "$XDG_DATA_HOME/zsh/zsh_history";
        save = 50000;
        size = 50000;
      };
      initExtra = builtins.readFile ./post-compinit.zsh;
      plugins = with pkgs; [
        rec {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "0.8.0-alpha1-pre-redrawhook";
            sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
          };
        }
	rec {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "0.34.0";
            sha256 = "0jjgvzj3v31yibjmq50s80s3sqi4d91yin45pvn3fpnihcrinam9";
          };
        }
        rec {
          name = "zsh-history-substring-search";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "v1.0.2";
            sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
          };
        }
      ];
    };
  };
}
