Cura
====

This is the source code of Cura.

## Dependencies

* Uranium
  Cura is built on top of the Uranium framework.
* CuraEngine
  This will be needed at runtime to perform the actual slicing.
* PySerial
  Only required for USB printing support.

## Testing and Debugging

If you need to reset all settings to start fresh, remove the following directories (on Linux):

* `~/.config/cura`
* `~/.local/share/cura`
