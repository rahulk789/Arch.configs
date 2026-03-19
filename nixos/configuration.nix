# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  qt.enable = true;
  # systemd.user.services.init-script = {
  #   serviceConfig.PassEnvironment = "DISPLAY";
  #   script = ''
  #     xinput set-button-map "$(xinput list --id-only 'pointer:Razer Razer DeathAdder V2 Mini')" 3 2 1
  #     xset r rate 200 35 &
  #     xrandr --output HDMI-1 --brightness 0.6 &
  #     nitrogen --set-zoom-fill ~/Downloads/wallhaven-j86kpw.jpg &
  #     xset s off &
  #     xset m 2/1 1 &
  #     '';
  #     wantedBy = ["graphical-session.target"]
  #   }
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
  };

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager.lightdm.enable = false;

    displayManager.sessionCommands = ''
      xinput set-button-map "$(xinput list --id-only 'pointer:Razer Razer DeathAdder V2 Mini')" 3 2 1
      xinput set-prop "$(xinput list --id-only 'pointer:Razer Razer DeathAdder V2 Mini')" "libinput Middle Emulation Enabled" 0
      xset r rate 200 35 &
      xrandr --output HDMI-0 --brightness 0.6 &
      nitrogen --set-zoom-fill /etc/nixos/assets/final-space-wall.jpg &
      xset s off &
      xset m 2/1 1 &
      '';
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;  # true if you're using open-source kernel module
  };
  security.wrappers.criu = {
    source = "${pkgs.criu}/bin/criu";
    capabilities = "cap_checkpoint_restore+ep";
    owner = "root";
    group = "root";
    permissions = "0755";
  };
  services.picom = {
    enable = true;
    backend = "xrender";
    fade = true;
  };
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = false;
    pulse.enable = false;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xenon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.nix-ld.enable = true;
  nixpkgs.config.chromium.enableWideVine = true;

  programs.criu.enable = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim duckdb bash-language-server shellcheck shfmt
    git zulu # java actually
    wget usbutils nmap docker-compose
    alacritty runc cri-tools containerd
    nitrogen restate
    pass mesa-demos # nvidia
    rustc rustup rustfmt vimPlugins.coc-rust-analyzer vimPlugins.coc-nvim vimPlugins.none-ls-nvim rust-analyzer nodejs yarn
    go libgcc pkg-config gnumake gcc bear vcpkg cmake clang clang-tools llvm gopls nil glow
    cudaPackages.cudatoolkit zip unzip ninja
    python314
    chromium osu-lazer kitty
    firefox hmcl prettierd
    htop kubernetes-helm betterdiscordctl
    screenfetch yaml-language-server
    sqlx-cli openssl openssl.dev sqlite poetry
    cargo postgresql ripgrep
    rofi atlauncher criu
    dmenu watchexec lsd yewtube
    pavucontrol asciinema asciinema-agg
    lxappearance gdb yt-dlp gpt-cli stream-rip
    noto-fonts vscode-langservers-extracted
    noto-fonts-cjk-sans cmatrix weechat
    noto-fonts-emoji
    jetbrains-mono bats
    folly gflags glog grpc libevent libunwind libuv protobuf
    jq xclip fzf flex bison autoconf automake libtool gnum4 elfutils
    home-manager slack terraform
    arc-theme nomacs gimp newsboat
    orchis-theme operator-sdk kubebuilder
    nordic just caddy parallel
    ranger vlc mpv yewtube lynx w3m tuir neomutt feh pnpm
    nemo simplescreenrecorder
    flameshot obs-studio kubectl eksctl awscli cloudsmith-cli
    (sddm-astronaut.override {
        themeConfig = {
          FontSize = "12";

          RoundCorners = "20";

          Background = "/etc/nixos/assets/final-space-wall.jpg";
          BackgroundSpeed = "1.0";
          PauseBackground = "";
          CropBackground = "true";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";

          PartialBlur = "true";
          BlurMax = "35";
          Blur = "2.0";

          HaveFormBackground = "false";
          FormPosition = "left";
        };
      })
  ];
  environment.variables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05";

}
