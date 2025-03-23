{ config, pkgs, lib,  ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "daniel.brandenburg";
  home.homeDirectory = "/home/daniel.brandenburg";
  
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Terminal utilities
    ripgrep
    fd
    stow
    fzf
    zoxide
    eza
    lazygit
    
    # Programming languages and tools
    go
    
    # Applications
    jetbrains-toolbox
    jetbrains.rider
    wezterm
    docker
    fira-code
    
  ];
  
  fonts.fontconfig.enable = true;


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    
    # Brave configuration for extensions
    brave = {
      enable = true;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      ];
    };

    # Neovim - just install the package, don't manage config
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      # No config here as it's managed by stow
    };

    # ZSH - just install the package, don't manage config
    zsh = {
      enable = true;
      # No config here as it's managed by stow
      
      # Oh My ZSH installation only
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" "zoxide" ];
        theme = "robbyrussell";
      };
    };
    



    # Git - just install the package
    git = {
    	enable = true;
    	userName = "Daniel Brandenburg";
    	userEmail = "brandendj@gmail.com";
    };

    # FZF installation only
    fzf.enable = true;

    # Zoxide installation only
    zoxide.enable = true;
  };

  home.file = {
    ".zshrc".source = "${config.home.homeDirectory}/.dotfiles/.zshrc";
    ".config/nvim".source = "${config.home.homeDirectory}/.dotfiles/.config/nvim";
    ".config/wezterm".source = "${config.home.homeDirectory}/.dotfiles/.wezterm.lua";
    ".ideavimrc".source = "${config.home.homeDirectory}/.dotfiles/.ideavimrc";
  };
  
    # Set default shell to Zsh
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  home.shellAliases = {
    sh = "zsh";
  };
  
  home.activation.setShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    chsh -s ${pkgs.zsh}/bin/zsh ${config.home.username}
  '';
  
    # Set default terminal to WezTerm
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = "org.wezfurlong.wezterm.desktop";
  };
  


  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
    };
  };
}
