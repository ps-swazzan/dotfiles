{ lib, config, pkgs, ... }:

{
  home.username = "swazzan";
  home.homeDirectory = "/Users/swazzan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    asciinema
    # azure-cli
    # bitwarden-cli
    eslint
    fd
    fx
    fzf
    gh
    git-crypt
    github-copilot-cli
    graphviz
    html-tidy
    htmlq
    hurl
    jq
    k9s
    mdcat
    mycli
    nodejs
    pandoc
    ripgrep
    shellcheck
    sleek
    timewarrior
    tree
    vault
    visidata
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    coc-settings = {
      source = ./vim/coc-settings.json;
      target = ".vim/coc-settings.json";
    };

    coc-mappings = {
      source = ./vim/coc-mappings.vim;
      target = ".vim/coc-mappings.vim";
    };

    kitty-conf = {
      source = ./kitty/kitty.conf;
      target = ".config/kitty/kitty.conf";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/saeidw/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim-darwin;

    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.catppuccin-vim
      pkgs.vimPlugins.fzfWrapper
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-json
      pkgs.vimPlugins.copilot-vim
      (pkgs.callPackage ./vim/omnisharp-vim.nix { })
    ];

    extraConfig = builtins.readFile ./vim/vimrc;
  };

  # FIXME: This is needed to address bug where the $PATH is re-ordered by
  # the `path_helper` tool, prioritising Apple’s tools over the ones we’ve
  # installed with nix.
  #
  # This gist explains the issue in more detail: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
  # There is also an issue open for nix-darwin: https://github.com/LnL7/nix-darwin/issues/122
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];

    loginShellInit =
      let
        # We should probably use `config.environment.profiles`, as described in
        # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
        # but this takes into account the new XDG paths used when the nix
        # configuration has `use-xdg-base-directories` enabled. See:
        # https://github.com/LnL7/nix-darwin/issues/947 for more information.
        profiles = [
          "/etc/profiles/per-user/$USER" # Home manager packages
          "$HOME/.nix-profile"
          "(set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)/nix/profile"
          "/run/current-system/sw"
          "/nix/var/nix/profiles/default"
        ];

        makeBinSearchPath =
          lib.concatMapStringsSep " " (path: "${path}/bin");
      in
      ''
        # Fix path that was re-ordered by Apple's path_helper
        fish_add_path --move --prepend --path ${makeBinSearchPath profiles}
        set fish_user_paths $fish_user_paths
      '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Saeid Al-Wazzan";
    userEmail = "89769259+ps-swazzan@users.noreply.github.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      push = {
        default = "simple";
      };
    };
  };
}
