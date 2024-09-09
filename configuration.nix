{ config, pkgs, inputs, ... }:

{
  # Import hardware configuration
  imports = [ ./hardware-configuration.nix ];

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking settings
  networking.hostName = "debbie";
  networking.networkmanager.enable = true;

  # Time and locale settings
  time.timeZone = "America/Denver";
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

  # X11 and KDE Plasma settings
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing settings
  services.printing.enable = true;

  # Sound settings with PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Enable JACK if needed
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental Nix features
  nix.settings.experimental-features = [ "nix-command" ];

  # Fish shell configuration
  programs.fish.enable = true;

  # User account configuration
  users.users.nate = {
    isNormalUser = true;
    home = "/home/nate";
    description = "Nate Stott";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kdePackages.kate
      librewolf
      alacritty
      jetbrains-toolbox
      protonvpn-gui
      github-desktop
      fish
      virtualbox
      discord
      slack
      zoom-us
      glow
      lsd
      docker-client
      rustup
      docker-compose
      papirus-nord
      gparted
      fastfetch
      bat
      htop-vim
      blanket
      pomodoro-gtk
      brave
      obsidian
      postgresql
      sqlite
      openssl
      bruno
      python312
      python312Packages.pip
      python312Packages.pipx
    ];
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    nix-ld
    curl
    firefox
    wget
    tldr
    tree
    glances # Add system monitoring tool
  ];

  # Font configuration
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;

  # Automatic system upgrades
  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };

  # Define the system state version
  system.stateVersion = "unstable";

  # Firewall settings for improved security
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ]; # Allow SSH, HTTP, HTTPS
    allowedUDPPorts = [ 53 ]; # Allow DNS
  };
}
