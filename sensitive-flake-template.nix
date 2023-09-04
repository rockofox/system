{
  inputs = { };
  outputs = inputs@{ self, ... }: {
    lib = rec {
      username = "";            # Username of the user
      homeDirectory = "";       # Home directory of the user
      systemFlakePath = "";     # Path to the system flake, used for the `rebuild` command
      obsidianVault = "";       # Path to the obsidian vault
      arch = "";                # Architecture of the system, e.g aarch64-darwin
    };
  };
}
