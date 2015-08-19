with import <nixpkgs> {};
with pkgs.python34Packages;

buildPythonPackage {
  name = "Deskbox-Cura";
  buildInputs = [
    python3
    python34Packages.numpy
    python34Packages.pyopengl
    python34Packages.pyqt5
    python34Packages.pyserial
    python34Packages.virtualenv
    # standard - do not remove
    stdenv
  ];
  src = null;
  # When used as `nix-shell --pure`
  shellHook = ''
    unset http_proxy
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    virtualenv --system-site-packages .python
    source .python/bin/activate
    pip install -r requirements.txt
  '';
  # used when building environments
  extraCmds = ''
    unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
  '';
}
