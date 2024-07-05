{ config, pkgs, ... }:

{
  home.username = "nates";
  home.homeDirectory = "/home/nates";
  
  home.stateVersion = "24.11";

  home.packages = [

  ];

  home.file = {

  };

  # configure programs
  programs = {
    git = {
      enable = true;
      userName = "Nate Stott";
      userEmail = "nate.stott@pm.me";
      aliases = {
        a = "add";
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
