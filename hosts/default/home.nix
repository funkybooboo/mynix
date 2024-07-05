{ config, pkgs, ... }:

{
  home.username = "nates";
  home.homeDirectory = "/home/nates";
  
  home.stateVersion = "24.11";

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs = {
    git = {
      enable = true;
      userName = "Nate Stott";
      userEmail = "nate.stott@pm.me";
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
