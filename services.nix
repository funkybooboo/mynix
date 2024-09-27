{ config, pkgs, ... }:

{
    # Enable X11 and Hyprland settings
    services.xserver.enable = true;
    services.displayManager.lightdm.enable = true;  # Enable LightDM as the display manager
    programs.hyprland.enable = true;                # Enable Hyprland

    # Keyboard layout configuration
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Enable printing services
    services.printing.enable = true;

    # Sound settings using PipeWire
    hardware.pulseaudio.enable = false;            # Disable PulseAudio
    security.rtkit.enable = true;                  # Enable real-time support
    services.pipewire = {
        enable = true;                              # Enable PipeWire
        alsa.enable = true;                         # Enable ALSA support
        alsa.support32Bit = true;                   # Support 32-bit ALSA applications
        pulse.enable = true;                        # Enable PulseAudio compatibility
        jack.enable = true;                         # Enable JACK support if needed
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
        htop-vim              # Interactive process viewer

    ];

    # Font configuration
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) # Use Nerd Font for JetBrainsMono
    ];
    fonts.fontconfig.enable = true;                 # Enable font configuration
}
