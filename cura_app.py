#!/usr/bin/env python3

# Copyright (c) 2015 Ultimaker B.V.
# Cura is released under the terms of the AGPLv3 or higher.

try:
    import sys, platform
    # When running in py2exe, disable the log feature by routing stdout/sterr to a different log.
    if platform.system() == 'Windows' and hasattr(sys, 'frozen'):
    	sys.stdout = sys.stderr = open("Cura.output.log", "w")
    import cura.CuraApplication
    app = cura.CuraApplication.CuraApplication.getInstance()
    app.run()
except Exception as e:
    # raise
    import cura.CrashHandler
    cura.CrashHandler.show()
