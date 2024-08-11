# [home-manager]
# git setup with gpg signing, assuming the gpg key is shared between machines
{config, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Jakub Arbet";
    userEmail = "hi@jakubarbet.me";
    signing = {
      key = config.gitSigningKey;
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      ".idea"
    ];
  };
}
