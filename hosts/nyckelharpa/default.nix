{
  pkgs,
  self,
  system,
  ...
}: {
  imports = [./homebrew.nix];

  # Necessary for using flakes on this system.
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      extra-platforms = aarch64-darwin
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  environment.variables = {EDITOR = "vim";};

  environment.systemPackages = with pkgs; [
    curl
    git
    wget
    (neovim.override {
      vimAlias = true;
    })
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  users.users.jakub.home = "/Users/jakub";

  # Add ability to use Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;
}