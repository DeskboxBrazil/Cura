with import <nixpkgs> {};
with pkgs.python27Packages;

buildPythonPackage {
    name = "impurePythonEnv";
    buildInputs = [
        stdenv
        python35
        python35Packages.ipython
        python35Packages.pyqt5
        #python35Packages.pyqtgraph
        python35Packages.pyserial
        python35Packages.virtualenv
        qt5Full
    ];
    src = null;
    # When used as `nix-shell --pure`
    shellHook = ''
        unset http_proxy
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    '';
    # used when building environments
    extraCmds = ''
        unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    '';
}
