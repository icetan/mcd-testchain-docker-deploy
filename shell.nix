# A Nix function which can be called with the optional argument `tdds-src`,
# the default value is a derivation which fetches the `master` branch of
# `testchain-dss-deployment-scripts` from GitHub.
#
# By calling this function with `{ tdds-src = /some/local/fs/path; }` you can inject
# any version of `tdds` when developing.
{ tdds-src ? fetchGit {
    url = https://github.com/makerdao/testchain-dss-deployment-scripts.git;
    ref = "master";
  }
}: let
  tdds-shell = import "${tdds-src}/shell.nix" {};
in
  tdds-shell.overrideAttrs (attrs: {
    src = tdds-src;
  })
