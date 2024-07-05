# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Networking.
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # Set up timezone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nates = {
  isNormalUser = true;
  home = "/home/nates";
  description = "Nate Stott";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.fish; # user shell
  packages = with pkgs; [ # user packages
      kdePackages.kate
      thunderbird
      librewolf
      alacritty
      jetbrains-toolbox
      protonvpn-gui
      protonmail-bridge-gui
      github-desktop
      fish
      wget
      virtualbox
      discord
      slack
      zoom-us
      tldr
      glow
      lsd
      docker-client
      rustup
      docker-compose
      papirus-nord
      gparted
      fastfetch
      tree
      bat
      htop-vim
      blanket
      pomodoro-gtk
      brave
      obsidian
      nodejs_20
      postgresql_16
      sqlite
      openssl_3_3
      bruno
    ];
  };
  
  # enable home manager to manager config files of programs
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nates" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    home-manager
  ];
  
  # System fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;
  
  # Allow nixos to run dynamically linked axecutables inteanded for generic Linux environment
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged 
    # programs here, NOT in environment.systemPackages
  ];
 
  # Auto upgrades
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" 
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };
  
  # What branch the system is on
  system.stateVersion = "unstable"; 

}
