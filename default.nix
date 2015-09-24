with import <nixpkgs> {};
with pkgs.python27Packages;

buildPythonPackage {
    name = "impurePythonEnv";
    buildInputs = [
        stdenv
        python34
        python34Packages.ipython
        python34Packages.numpy
        python34Packages.pyqt5
        #python34Packages.pyqtgraph
        python34Packages.pyserial
        python34Packages.sip_4_16
        python34Packages.virtualenv
        qt5Full
        qt5.declarative
        #qt5.quick1
        qt5.quickcontrols
        #protobuf3_0
    ];
    src = null;
    # When used as `nix-shell --pure`
    shellHook = ''
        unset http_proxy
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
        export LD_LIBRARY_PATH="${qt5.declarative}/lib:${qt5.quick1}/lib:${qt5.quickcontrols}/lib"
        export PYTHONPATH="${python34Packages.numpy}/lib/python3.4/site-packages:${python34Packages.pyqt5}/lib/python3.4/site-packages:${python34Packages.pyserial}/lib/python3.4/site-packages:${python34Packages.sip_4_16}/lib/python3.4/site-packages:$PYTHONPATH"
        #echo "${protobuf3_0}"
    '';
    # used when building environments
    extraCmds = ''
        unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    '';
}
