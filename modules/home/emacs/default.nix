{ colorScheme, font, pkgs, lib, ... }:
with lib;
let
   copilot-el = pkgs.fetchFromGitHub {
      owner = "zerolfx";
      repo = "copilot.el";
      rev = "7cb7beda89145ccb86a4324860584545ec016552";
      sha256 = "sha256-57ACMikRzHSwRkFdEn9tx87NlJsWDYEfmg2n2JH8Ig0=";
   };
in rec
{
  home.packages = with pkgs; [

  ];
  home.sessionVariables = {
    EMACS_PATH_COPILOT = "${copilot-el}";
  };
  programs.zsh.initExtra = "export EMACS_PATH_COPILOT=${copilot-el}";
  programs.doom-emacs = rec {
    enable = true;
    doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el and packages.el files
    # Only init/packages so we only rebuild when those change.
    doomPackageDir = let
      filteredPath = builtins.path {
        path = doomPrivateDir;
        name = "doom-private-dir-filtered";
        filter = path: type:
          builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
      };
    in pkgs.linkFarm "doom-packages-dir" [
      {
        name = "init.el";
        path = "${filteredPath}/init.el";
      }
      {
        name = "packages.el";
        path = "${filteredPath}/packages.el";
      }
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
    ];
    emacsPackagesOverlay = self: super: {
      copilot = self.trivialBuild {
        pname = "copilot";
        ename = "copilot";
        version = "7cb7bed";
        buildInputs = with self; [ dash s editorconfig ];
        src = copilot-el;
      };
      base16-current-theme = self.trivialBuild { # See packages.el
          pname = "base16-current-theme";
          ename = "base16-current-theme";
          version = "0.0.1";
          buildInputs = with self; [ base16-theme ];
          src = pkgs.writeText "base16-current-theme.el" ''
            (require 'base16-theme)
            (defvar base16-current-colors
              '(:base00 "#${colorScheme.palette.base00}"
                :base01 "#${colorScheme.palette.base01}"
                :base02 "#${colorScheme.palette.base02}"
                :base03 "#${colorScheme.palette.base03}"
                :base04 "#${colorScheme.palette.base04}"
                :base05 "#${colorScheme.palette.base05}"
                :base06 "#${colorScheme.palette.base06}"
                :base07 "#${colorScheme.palette.base07}"
                :base08 "#${colorScheme.palette.base08}"
                :base09 "#${colorScheme.palette.base09}"
                :base0A "#${colorScheme.palette.base0A}"
                :base0B "#${colorScheme.palette.base0B}"
                :base0C "#${colorScheme.palette.base0C}"
                :base0D "#${colorScheme.palette.base0D}"
                :base0E "#${colorScheme.palette.base0E}"
                :base0F "#${colorScheme.palette.base0F}")
            "All colors for ${colorScheme.slug} are defined here.")
            ;; Define the theme
            (deftheme base16-current)

            ;; Add all the faces to the theme
            (base16-theme-define 'base16-current base16-current-colors)

            ;; Mark the theme as provided
            (provide-theme 'base16-current)

            ;; Add path to theme to theme-path
            (add-to-list 'custom-theme-load-path
                (file-name-directory
                    (file-truename load-file-name)))

            (provide 'base16-current-theme)
        '';
        };
    };
    extraConfig = ''
      ;; (require 'base16-current-theme) <- Broken ATM
      (setq doom-font "${font}:pixelsize=16")
      ;; (setq doom-theme 'base16-current)
      (use-package! copilot
        :config (setq copilot--base-dir "${copilot-el}")
        :hook (prog-mode . copilot-mode)
        :bind (:map copilot-completion-map
                    ("<tab>" . 'copilot-accept-completion)
                    ("TAB" . 'copilot-accept-completion)
                    ("C-TAB" . 'copilot-accept-completion-by-word)
                    ("C-<tab>" . 'copilot-accept-completion-by-word)))
    '';
    emacsPackage = pkgs.emacsPgtk.overrideAttrs (old: rec {
      patches =
        (old.patches or [])
        ++ [
          # Fix OS window role (needed for window managers like yabai)
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/fix-window-role.patch";
            sha256 = "sha256-+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
          })
          # Use poll instead of select to get file descriptors
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-29/poll.patch";
            sha256 = "sha256-jN9MlD8/ZrnLuP2/HUXXEVVd6A+aRZNYFdZF8ReJGfY=";
          })
          # Enable rounded window with no decoration
          # (pkgs.fetchpatch {
          #   url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-29/round-undecorated-frame.patch";
          #   sha256 = "sha256-uYIxNTyfbprx5mCqMNFVrBcLeo+8e21qmBE3lpcnd+4=";
          # })
          # Make Emacs aware of OS-level light/dark mode
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/system-appearance.patch";
            sha256 = "sha256-oM6fXdXCWVcBnNrzXmF0ZMdp8j0pzkLE66WteeCutv8=";
          })
        ];
    });
  };
}
