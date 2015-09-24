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
        python34Packages.pyqtgraph
        python34Packages.pyserial
        python34Packages.sip_4_16
        python34Packages.virtualenv
        qt5Full
        qt5.quickcontrols
        xorg_sys_opengl 
    ];
    src = null;
    # When used as `nix-shell --pure`
    shellHook = ''
        unset http_proxy
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
        export LD_LIBRARY_PATH="${qt5Full}/lib"
        export QML_IMPORT_PATH="${qt5Full}/lib/qt5/qml:${qt5.quickcontrols}/lib/qt5/qml"
        export QML2_IMPORT_PATH="${qt5Full}/lib/qt5/qml:${qt5.quickcontrols}/lib/qt5/qml"
        export QT_QPA_PLATFORM_PLUGIN_PATH="${qt5Full}/lib/qt5/plugins/platforms"
        export QT_PLUGIN_PATH="${qt5Full}/lib/qt5/plugins"
        #export QT_DEBUG_PLUGINS=1
        export PYTHONPATH="${python34Packages.numpy}/lib/python3.4/site-packages:${python34Packages.pyqt5}/lib/python3.4/site-packages:${python34Packages.pyserial}/lib/python3.4/site-packages:${python34Packages.sip_4_16}/lib/python3.4/site-packages"
        virtualenv-3.4 --system-site-packages .python
        .python/bin/pip install 'protobuf>=3.0.0a3'
        source .python/bin/activate
        python cura_app.py
    '';
    # used when building environments
    extraCmds = ''
        unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    '';
}
