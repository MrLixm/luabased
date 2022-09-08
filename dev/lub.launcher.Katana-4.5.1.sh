# Katana launcher script

cd ..

KATANA_VERSION="4.5v1"
KATANA_HOME="C:\Program Files\Katana$KATANA_VERSION"
KATANA_TAGLINE="luabased DEV"

export PATH="$PATH;$KATANA_HOME\bin"

export KATANA_USER_RESOURCE_DIRECTORY=".\dev\_prefs"

export LUA_PATH="$LUA_PATH;.\?.lua"
#export LUA_PATH="$LUA_PATH;.\lllogger\?.lua"

"$KATANA_HOME\bin\katanaBin.exe"
