# Some things that you might want to change.
# This file should normally be ignored by git so you can change these variables independent of remote
rec {
  username = "rocko";
  homeDirectory = "/Users/${username}";
  systemFlakePath = "${homeDirectory}/GitClones/system";
  obsidianVault =
    "${homeDirectory}/Library/Mobile Documents/iCloud~md~obsidian/Documents/My Vault/";
}
