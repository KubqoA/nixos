{ config, lib, options, ... }:

with lib;
{
  options = with types; {
    user = _.mkOpt attrs {} "For passing options to ‹users.users.username›";
    username = mkOption {type = str; description = "The login username";};
    fullname = mkOption {type = str; description = "The full name";};
    email = mkOption {type = str; description = "The email, used for example in git settings";};
    gpgkey = mkOption {type = str; description = "GPG signing key, used for example in git settings";};
    sshkey = mkOption {type = str; description = "GPG authorization subkey, used for gpg-agent ‹› ssh support";};
    desktop = _.mkOpt bool false "Whether the current config is for a desktop";
    hm = _.mkOpt attrs {} "For passing options to ‹home-manager.users.username›";
  };

  config = {
    users.users.${config.username} = mkAliasDefinitions options.user;
    home-manager.users.${config.username} = mkAliasDefinitions options.hm;
    home-manager.useGlobalPkgs = true;
  };
}
