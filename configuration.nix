# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./unstable.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network.
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Zagreb";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hr_HR.UTF-8";
    LC_IDENTIFICATION = "hr_HR.UTF-8";
    LC_MEASUREMENT = "hr_HR.UTF-8";
    LC_MONETARY = "hr_HR.UTF-8";
    LC_NAME = "hr_HR.UTF-8";
    LC_NUMERIC = "hr_HR.UTF-8";
    LC_PAPER = "hr_HR.UTF-8";
    LC_TELEPHONE = "hr_HR.UTF-8";
    LC_TIME = "hr_HR.UTF-8";
  };
  
  # Keyboard.
  services.xserver = {
    layout = "hr";
    xkbVariant = "";
  };
  
  # Configure console keymap
  console.keyMap = "croat";

  # Fish shell
  programs.fish.enable = true;
  
  # Display Manager.
  services.xserver.displayManager = {
	lightdm.enable = true;
  	autoLogin = {
		enable = true;
		user = "marin";
	};
  };

  # Services/other.
  services.picom.enable = true;
  virtualisation.libvirtd.enable = true; 
  services.flatpak.enable = true;
  services.dbus.enable = true;
  virtualisation.podman.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.config.allowUnfree = true;


  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    
    };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marin = {
     isNormalUser = true;
     description = "marin";
     extraGroups = [ "wheel" "kvm" "input" "disk" "libvirtd" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
	alacritty
  brave
	deluge-gtk
	distrobox
	dmenu
	dunst
	dwm
	feh
	fish
	gcc
	gh
	git
	gnome.gedit
	gnugrep
	gnumake
	gparted
	libverto
	lxappearance
	mate.engrampa
	neovim
	neovim
	nfs-utils
	ninja
	nodejs
	nomacs
	pamixer
	pavucontrol
	picom
	podman
	polkit_gnome
	protonup-ng
	ripgrep
	rofi
	spotify
	stdenv
	sxhkd
	terminus-nerdfont
	tldr
	trash-cli
	unzip
	variety
	w3m
	wget
	xclip
	xdg-desktop-portal-gtk
	xfce.thunar
	xorg.xhost
	xorg.xinit
	xorg.xsetroot
  discord
  fontconfig
  freetype
  luarocks
  neofetch
  vim
  vscodium
  xorg.libX11
  xorg.libX11.dev
  xorg.libxcb
  xorg.libXft
  xorg.libXinerama
  xorg.xinput
	
	
  ];

  # Dwm and dmenu compile.
  nixpkgs.overlays = [
	(final: prev: {
		dwm = prev.dwm.overrideAttrs (old: { src = /home/marin/dwm ;});
    dmenu = prev.dmenu.overrideAttrs (old: { src = /home/marin/dmenu ;});
	})
  ];
  
  
  # XDG portal.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
 # Polkit.
 systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
   extraConfig = ''
     DefaultTimeoutStopSec=10s
   '';
 }; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking.enableIPv6 = false;

 # Fonts.
 fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      hack-font
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
	      monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
	      serif = [ "Noto Serif" "Source Han Serif" ];
	      sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
 };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;
  system.autoUpgrade.enable = false;  
  system.autoUpgrade.allowReboot = false; 
  
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
