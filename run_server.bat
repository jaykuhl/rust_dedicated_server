#!/bin/bash

# Set the SteamCMD path

STEAMCMD_DIR="/path/to/steamcmd"

# Set the Rust server installation path

RUST_DIR="/path/to/rustserver"

# Set the login credentials for your Steam account

STEAM_USERNAME="yourusername"

STEAM_PASSWORD="yourpassword"

# Set the update interval in minutes

UPDATE_INTERVAL=60

while true

do

    # Change to the SteamCMD directory

    cd $STEAMCMD_DIR

    # Check if there is a game update available

    update_output=$(./steamcmd.sh +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir $RUST_DIR +app_update 258550 +quit | grep "Success! App '258550' fully installed.")

    # If there is a game update available, download and install it

    if [ -n "$update_output" ]

    then

        # Update the Rust dedicated server using SteamCMD

        ./steamcmd.sh +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir $RUST_DIR +app_update 258550 validate +quit

        # Restart the Rust dedicated server

        cd $RUST_DIR

        ./RustDedicated -batchmode -nographics +server.port 28015 +server.hostname "My Rust Server" +server.maxplayers 50

    fi

    # Wait for the update interval

    sleep $((UPDATE_INTERVAL * 60))

done

