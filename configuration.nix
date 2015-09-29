# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  environment.systemPackages = with pkgs; [
    wget
    sudo
    manpages
    gitAndTools.gitFull
    iptables
    nmap
    tcpdump
    zlib
    zsh
    bc
    gcc
    binutils
    nix
    # haskellPackages.haskellPlatform
    haskellPackages.xmobar
    haskellPackages.xmonad
    # haskellPackages.xmonadContrib
    # haskellPackages.xmonadExtras
    xfontsel
    xlsfonts
    cabal2nix
    chromium
    dmenu
    xscreensaver
    xclip
    # virtualbox
  ];
  
  # users.extraGroups.wheel.gid = 0;
  users.extraUsers.josiah  = {
    createHome = true;
    home = "/home/josiah";
    description = "Josiah";
    extraGroups = [ "wheel" ];
    isSystemUser = false;
    useDefaultShell = true;
  };
  security.sudo.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    
    # Keyboard config
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "esc:caps,caps:esc";

    # XMonad config
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";

    # Everything else
    desktopManager.xterm.enable = true;
    desktopManager.kde4.enable = true;
    desktopManager.default = "none";
    displayManager.kdm.enable = true;
    wacom.enable = true;
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
