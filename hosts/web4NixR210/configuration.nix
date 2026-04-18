{ config, pkgs, lib, ... }:

{
  system.stateVersion = "25.05";

  networking.hostName = "web4NixR210";

  # Locale / timezone / keymap
  time.timeZone = "Africa/Johannesburg";
  i18n.defaultLocale = "en_ZA.UTF-8";
  console.keyMap = "us";

  # Bootloader: EFI GRUB
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Networking (wired DHCP)
  networking.useDHCP = lib.mkDefault true;

  # Open only SSH for now
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };

  # Tailscale
  services.tailscale.enable = true;

  # User
  users.users.web4 = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "lxd"
      "libvirtd"
      "kvm"
    ];
    # Replace with your real public key:
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAA_REPLACE_WITH_WEB4_KEY"
    # ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # optional: root admin key
  ];

  # Virtualization / containers
  virtualisation = {
    lxd.enable = true;      # LXD/LXC
    libvirtd.enable = true; # KVM/libvirt VMs
  };
  programs.virt-manager.enable = true;

  # Helpful packages
  environment.systemPackages = with pkgs; [
    tree
    curl
    git
    vim
    tailscale
    lxc
    lxd
    qemu_kvm
    libvirt
    virt-manager
    bridge-utils
    dnsmasq
  ];
}
