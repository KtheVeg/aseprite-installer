# This script was written by KtheVeg (https://github.com/KtheVeg)
# This script loosely follows what's mentionned in the following link https://alexgonzalezc.dev/posts/how-to-build-aseprite-from-source.html, however, it was adapted to be functional in 22.04 instead of 18.04
# Tested in a fresh installation of Pop!_OS 22.04. Results may vary

# LICENSE: Follows the MIT 3.0 license

# Also, for whoever reads through this code, you can improve it at https://github.com/KtheVeg

# A few functions often used
function chkmkdir {
	if [[ ! -d $1 ]]; then 
        mkdir $1
    else
        rm -R $1 && mkdir $1
    fi
}

function failCheck {
    if [ $1 -ne 0 ]; then # This code is reused so many times. Adding a simple function
    	echo $2
	    exit $1
    fi
}




# Start actual install flow
echo "Installing Aseprite"
echo "==================="
echo
echo "Note: Sudo access required for deps download. To skip deps download, export SKIPDEPS=1"

# Check arguments
installDirectory=$PWD
if [[ $1 != "" ]]; then
    if [ -f $1 ]; then
        installDirectory=$1
    fi
fi
buildDirectory=$PWD
if [[ $2 != "" ]]; then
    if [ -f $2 ]; then
        buildDirectory=$2
    fi
fi

# Let the user know where it's going to be installed/built
echo "INFO: Installing to $installDirectory/aseprite. To change, set first variable to a valid path"
echo "INFO: Building temp files to to $buildDirectory/asepritebuild. To change, set second variable to a valid path"

# Install dependancies if not skipped
if [[ $SKIPDEPS -ne 1 ]]; then
    echo "INFO: Downloading required deps"
    sudo apt-get install -y g++ cmake ninja-build libx11-dev libxcursor-dev libgl1-mesa-dev libfontconfig1-dev xorg-dev git unzip wget
    retval=$?
    if [ $retval -ne 0 ]; then # Deps download doesn't fail if they're already downloaded, so if it simply fails, then it's probably gonna fail, so we exit prematurely
    	echo "ERROR: Dependancy Downloads failed. Can't continue"
	    exit $retval
    fi
else
    echo "WARN: Deps download manually skipped"
fi


# Basically set up temporary build directories
echo "INFO: Setting up directory structure"
cd $buildDirectory
chkmkdir asepritebuild
cd asepritebuild
chkmkdir deps
cd deps
mkdir skia
# We should now be in a completely clean directory

echo "INFO: Downloading Skia Build (x64)"
# Download and extract https://github.com/aseprite/skia/releases/latest/download/Skia-Linux-Release-x64-libstdc++.zip
wget https://github.com/aseprite/skia/releases/latest/download/Skia-Linux-Release-x64-libstdc++.zip
failCheck $? "ERROR: Failed to download Skia. Exit."
unzip Skia-Linux-Release-x64-libstdc++.zip -d skia
failCheck $? "ERROR: Failed to extract Skia. Unzip Fail"

cd $buildDirectory/asepritebuild

echo "INFO: Downloading Aseprite Source Code"
git clone --recursive https://github.com/aseprite/aseprite.git
failCheck $? "ERROR: Failed to get Aseprite Source"
echo "INFO: Downloaded Aseprite Source Code. Building"
cd aseprite
mkdir build
cd build

echo "INFO: Generating build files"
cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DLAF_OS_BACKEND=skia \
  -DSKIA_DIR=$buildDirectory/asepritebuild/deps/skia \
  -DSKIA_OUT_DIR=$buildDirectory/asepritebuild/deps/skia/out/Release \
  -G Ninja \
  ..
failCheck $? "ERROR: Failed to generate build files"
echo "INFO: Building Aseprite"
ninja aseprite
failCheck $? "ERROR: Failed to build"
cd ..

echo "INFO: Installing Aseprite"
cp -R build/bin $installDirectory/aseprite

echo "INFO: Aseprite installed to $installDirectory/aseprite"

echo "-- ASEPRITE WAS COMPILED --"
echo "To run, type $installDirectory/aseprite/aseprite"
echo "To uninstall, delete $installDirectory/aseprite"

#if [[ $SKIP_UPDATER -ne 1 ]]; then
#    echo "INFO: Installing Aseprite Updater"
    
#    echo "INFO: Step 1: Copying Build files"
#    cp $buildDirectory/asepritebuild $installDirectory/aseupdbld
#    failCheck $? "ERROR: Failed to copy build files"
#    
#    echo "INFO: Step 2: Hashing skia"
#    cd $installDirectory/aseupdbld/deps
#    sha256sum skia/Skia-Linux-Release-x64-libstdc++.zip > skia.sha256
#    failCheck $? "ERROR: Failed to hash skia"

#    echo "INFO: Step 3: Downloading update script"
#    wget https://github.com/ktheveg/aseprite-installer/releases/latest/download/updater.sh

#fi

echo "==================="
echo "Thanks for using the unofficial aseprite auto-compiler"