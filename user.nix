{ config, pkgs, ... }:

{
    # Fish shell configuration
    programs.fish.enable = true;

    # User account configuration
    users.users.nate = {
        isNormalUser = true;
        home = "/home/nate";
        description = "Nate Stott";
        extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" ]; # Add user to necessary groups
        shell = pkgs.fish;
        packages = with pkgs; [
            # Terminal and Shell Utilities
            alacritty             # Terminal emulator
            bat                   # Syntax highlighting cat
            glow                  # Markdown renderer
            fzf                   # Command-line fuzzy finder
            make                  # Build automation tool
            cmake                 # Cross-platform build system generator
            gulp                  # Toolkit for automating tasks

            # Communication Tools
            discord               # Communication platform
            zoom-us               # Video conferencing

            # Web Browsers
            google-chrome         # Google Chrome
            librewolf             # Privacy-focused web browser

            # Development Tools
            neovim                # Text editor

            # Java Development
            jdk22                 # Java Development Kit

            # Python Development
            python312             # Python 3.12
            python312Packages.pip # Package installer for Python
            python312Packages.pipx # Install Python applications in isolated environments
            python312Packages.flask      # Flask web framework
            python312Packages.django     # Django web framework
            poetry                # Dependency management for Python

            # Go Development
            go                    # Go programming language

            # Rust Development
            rustup                # Rust programming language installer

            # C++ Development
            gcc                   # GNU Compiler Collection
            clang-tidy            # C++ linter
            clang-format          # Code formatter for C/C++

            # JavaScript Development
            nodejs                # JavaScript runtime
            npm                   # Node package manager

            # API Development Tools
            postman               # API testing tool
            bruno                 # Alternative to Postman

            # Docker Tools
            docker                # Container runtime
            docker-compose        # Multi-container Docker applications

            # JetBrains Products
            intellij-idea-ultimate   # Ultimate Edition
            pycharm-professional      # Professional Edition
            webstorm                  # WebStorm
            phpstorm                  # PhpStorm
            rubymine                  # RubyMine
            goland                    # GoLand
            clion                     # CLion
            datagrip                  # DataGrip
            rider                     # Rider

            # Image and Media Tools
            feh                   # Lightweight image viewer
            pavucontrol           # PulseAudio volume control

            # Hyprland Utilities
            hyprland-hyprpaper     # Wallpaper manager for Hyprland
            rofi                   # Application launcher
            waybar                 # Status bar
            mako                   # Notifications
            wofi                   # Menu for Wayland
            grim                   # Screenshot utility
            slurp                  # Select area for screenshots
        ];
    };

    # Docker service configuration
    services.docker = {
        enable = true;           # Enable Docker service
    };
}
