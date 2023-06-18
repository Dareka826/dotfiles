# vim: shiftwidth=2
{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
    ./graphical.nix
  ];
  #imports = [ ./core.nix ]
  #  ++ if builtins.getEnv "MYENV" == "HOME"
  #     then [ ./personal.nix ]
  #     else [ ./work.nix ];

  home.username = "rin";
  home.homeDirectory = "/home/rin";

  home.packages = with pkgs; [
    neovim

    fd
    bat
    exa
    pipx
    jq
    ripgrep
    hyperfine

    htop
    goredo
    proot
    dar
    mandown
    rtx

    # # Override packages:
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # Create simple shell scripts:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Managing dotfiles:
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # Set the file content:
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/rin/etc/profile.d/hm-session-vars.sh
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    BROWSER = "firefox";
    VIDEO = "mpv";
    IMAGE = "nsxiv";
    PAGER = "less";
    WM = "sway";
  };

  # Gtk sort directories first
  dconf.settings = {
    "org/gtk/Settings/FileChooser"      = { sort-directories-first = true; };
    "org/gtk/gtk4/Settings/FileChooser" = { sort-directories-first = true; };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
