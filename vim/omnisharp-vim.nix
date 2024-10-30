{ lib, config, pkgs, ... }:

pkgs.vimUtils.buildVimPlugin {
  name = "omnisharp-vim";
  src = pkgs.fetchFromGitHub {
    owner = "OmniSharp";
    repo = "omnisharp-vim";
    rev = "2205888fdcaf2b6008d115f343ddc31697a62151";
    hash = "sha256-A3cMQbGFcg6hbs5mh97hch5lckzI2ZI0Gglm55hpLvs=";
  };
}
