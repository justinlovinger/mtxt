# mtxt
Send quick and easy text messages with `mblaze`.
`mtxt` is a simple wrapper
around `mcom`.
It lets you quickly compose and send emails
through the command line
without entering an editor.

## Usage
You can send a quick message
like `mtxt -to "John Doe <johndoe@example.com>" Hey there!`.

An alias can make for easier operation,
like `alias jdtxt='mtxt -to "John Doe <johndoe@example.com>"'`.
Then,
you can send a message
like `jdtxt Hey!`.

Without text,
`mtxt` will fallback to `mcom`
and enter an editor.

Most options are passed through
to `mcom`.
If you don't want your message to send immediately,
you can add the `-nosend` option.

## Installation
### NixOS
Add a Nix overlay like
```
nixpkgs.overlays = [
  (self: super: {
    mtxt = (import (self.fetchFromGitHub {
      owner = "JustinLovinger";
      repo = "mtxt";
      rev = "LATEST_VERSION_TAG";
      sha256 = "SHA256_OF_LATEST_VERSION_TAG";
    }) { pkgs = self; });
  })
];
```

Get the `sha256`
with `nix run nixpkgs.nix-prefetch-github -c nix-prefetch-github --rev "LATEST_VERSION_TAG" JustinLovinger mtxt`.

Add the package like
```
environment.systemPackages = with pkgs; [
  mtxt
];
```

### Other Linux
Put `mtxt` file in bin.
