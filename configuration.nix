{ config, pkgs, ... }:

{
    # Import hardware configuration
    imports = [
        ./hardware-configuration.nix
        ./user.nix
        ./services.nix
    ];

    # Bootloader settings
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking settings
    networking.hostName = "debbie";
    networking.networkmanager.enable = true;

    # Time and locale settings
    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable experimental Nix features
    nix.settings.experimental-features = [ "nix-command" ];

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