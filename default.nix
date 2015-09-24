with import <nixpkgs> {};
with pkgs.python27Packages;

buildPythonPackage {
    name = "impurePythonEnv";
    buildInputs = [
        stdenv
        ######
        python34
        python34Packages.ipython
        python34Packages.numpy
        python34Packages.pyqt5
        python34Packages.pyqtgraph
        python34Packages.pyserial
        python34Packages.sip_4_16
        python34Packages.virtualenv
        # Other deps
        mesa
        mesa_drivers
        mesa_glu
        qt5Full
        qt5.quickcontrols
        xlibs.libXdamage
        xlibs.libXfixes
        xorg_sys_opengl
        xlibs.libxcb
        xlibs.libX11
        xlibs.libxshmfence
        xlibs.xcbutilkeysyms
    ];
    src = null;
    # When used as `nix-shell --pure`
    shellHook = ''
        unset http_proxy
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
        export LD_LIBRARY_PATH="$(pwd)/lib:${qt5Full}/lib:${xorg_sys_opengl}/lib:${mesa}/lib:${mesa_drivers}/lib:${mesa_glu}/lib:${xlibs.libXdamage}/lib:${xlibs.libXfixes}/lib:${xlibs.libxcb}/lib:${xlibs.libX11}/lib:${xlibs.libxshmfence}/lib:${xlibs.xcbutilkeysyms}/lib:${python34}/lib"
        export QML_IMPORT_PATH="${qt5Full}/lib/qt5/qml:${qt5.quickcontrols}/lib/qt5/qml"
        export QML2_IMPORT_PATH="${qt5Full}/lib/qt5/qml:${qt5.quickcontrols}/lib/qt5/qml"
        export QT_QPA_PLATFORM_PLUGIN_PATH="${qt5Full}/lib/qt5/plugins/platforms"
        export QT_PLUGIN_PATH="${qt5Full}/lib/qt5/plugins"
        #export QT_DEBUG_PLUGINS=1
        export PYTHONPATH="${python34Packages.numpy}/lib/python3.4/site-packages:${python34Packages.pyqt5}/lib/python3.4/site-packages:${python34Packages.pyserial}/lib/python3.4/site-packages:${python34Packages.sip_4_16}/lib/python3.4/site-packages"

        mkdir -p $(pwd)/lib
        ln -s ${xlibs.libxcb}/lib/libxcb.so.1 $(pwd)/lib/libX11-xcb.so.1

        #virtualenv-3.4 --system-site-packages .python
        #.python/bin/pip install 'protobuf>=3.0.0a3'
        #source .python/bin/activate
        python cura_app.py
    '';
    # used when building environments
    extraCmds = ''
        unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
        export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
    '';
}
