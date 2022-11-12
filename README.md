# Aseprite Installer
A basic installer that downloads and builds Aseprite from scratch.

REMEMBER TO GO BUY ASEPRITE IF YOU LIKE THE SOFTWARE

This script intends to make it easier to install...

...except that it's on Linux. You probably can easily compile Aseprite if you use Linux

# Install Stuff
FOR UBUNUT-BASED DISTROS ONLY ONLY (Might make a windows batch soon... maybe)

Download the shell script from releases. Mark executable then run from command line, and run.
Customize the install process with the following arguments

# Arguments
Want to change your build parameters? Here's a few switches to change how the program is installed/built

`SKIPDEPS=1`: (`export` variable only) If all required packages are already installed, you can skip the download/install of deps. Useful if you don't have `sudo` rights... But you probably wouldn't have all required packages anyway, though...

`NUKEDEPS=1`: (`export` variable only) I don't recommend for those who actively use these libraries, especially if installed by other libraries... It's gonna basically uninstall all the freshly downloaded dependancies once done compiling... Why tbough?

`CLEARBUILD=1`: (`export` variable only) If you don't plan on recompiling, you can automatically delete all build files when you're done

`<first arg>`: Install Directory. Specifying the install directory here will copy all required built files once finished compiling

`<second arg>`: Build Directory. Specifying the build directory will place all non-`apt` dependancies and build files into here

(Will be updated in the future)
