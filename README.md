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

If you need to reset all settings to start testing fresh, remove the following directories:

### Linux
* `~/.config/cura`
* `~/.local/share/cura`

### OS X
* `~/.cura`


## Development

1. Start the development VM.
```shell
vagrant up
```  
2. Login to the VM with user `vagrant`, password `vagrant`.
3. Open a console/terminal window and run:
```shell
cd /deskbox/Cura
python3 cura_app.py
```
