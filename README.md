# Aseprite Installer
A basic installer that downloads and builds Aseprite from scratch.

REMEMBER TO GO BUY ASEPRITE IF YOU LIKE THE SOFTWARE

This script intends to make it easier to install...

...except that it's on Linux. You probably can easily compile Aseprite if you use Linux

# Install Stuff
FOR UBUNTU-BASED DISTROS ONLY (Might make a windows batch soon... maybe)

Download the shell script from releases. Mark executable then run from command line, and run.
Customize the install process with the following arguments

# Arguments
Want to change your build parameters? Here's a few switches to change how the program is installed/built

### Export Globals
`SKIPDEPS=1`: If all required packages are already installed, you can skip the download/install of deps. Useful if you don't have `sudo` rights... But you probably wouldn't have all required packages anyway, though...

`NUKEDEPS=1`: I don't recommend for those who actively use these libraries, especially if installed by other libraries... It's gonna basically uninstall all the freshly downloaded dependancies once done compiling. I strongly discourage using this option, as some other software may require these deps

`SKIP_UPDATER=1`: If you don't plan on using the updater/recompiler I added, use this and the updater will exit before downloading and packing my installer

`HOLD_BUILD=1`: By default, all build files are discarded (excluding files for the updater). If you want to keep all the build files, you can do so.

`USE_UNSTABLE=1`: By default, the installer will download from RELEASES. If you prefer, you can also get the latest commits by specifying this setting.


### Arguments
`<first arg>`: Install Directory. Specifying the install directory here will copy all required built files once finished compiling (Please note - it will be installed to a subfolder called `aseprite` within the directory you specify). Default to current working directory

`<second arg>`: Build Directory. Specifying the build directory will place all non-`apt` dependancies and build files into here (Please note - it will be installed to a subfolder called `asepritebuild` within the directory you specify). Usually you don't need to change it. Defaults to current working directory

# Updater

By default, the installer will package an updater. The updater will keep a copy of all nessecary build files as well as an additional script that you can run to redownload and update Aseprite by reusing previously downloaded deps and reusing options that were used when initially building Aseprite

(Will be updated in the future)
