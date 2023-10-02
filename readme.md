# Rust          
The following repository contains the source files for building a Rust server.


### Running
To run the container, issue the following example command:
```
docker run -d \
-p 28015:28015/udp \
-p 28015:28015/tcp \
-p 28016:28016/tcp \
-e RUST_SERVER_NAME="DOCKER RUST" \
ghcr.io/netwarlan/rust
```

### Environment Variables
We can make dynamic changes to our Rust containers by adjusting some of the environment variables passed to our image.
Below are the ones currently supported and their (defaults):

Environment Variable | Default Value | Description
-------------------- | ------------- | -----------
RUST_SERVER_NAME | Docker Rust | Name of server
RUST_SERVER_DESCRIPTION | This Rust server is going to be awesome! | Server Description
RUST_SERVER_PORT | 28015 | Port used to connect to rust server. (Default is 28015)
RUST_APP_PORT | 28082 | Port used to connect tot he Rust+ app. (Default is 28082)
RUST_SERVER_LEVEL | Procedural Map | Map to use
RUST_SERVER_IDENTITY | rust | Used to distinguish different servers
RUST_SERVER_SEED | 12345 | Seed used to generate random map
RUST_SERVER_WORLDSIZE | 3000 | Size of the world. (2000 is smallest, 6000 is largest)
RUST_SERVER_MAXPLAYERS | 100 | Number of players that can actively join server.
RUST_SERVER_URL | https://netwar.org | Server URL
RUST_SERVER_HEADER_IMAGE | https://www.netwar.org/wp-content/uploads/2018/01/Netwar_Logo.png | Image used when in game server browser
RUST_SERVER_SAVE_INTERVAL | 300 | In seconds, how often the server will save world state
RUST_RCON_ENABLE | false | Used to enable or disable RCON support
RUST_RCON_PORT | 28016 | Port used for RCON
RUST_RCON_PASSWORD | n/a | Password used for RCON
RUST_UMOD_ENABLED | false | UMOD/Oxide mods enabled or disabled
RUST_UMOD_UPDATE_ON_BOOT | false | When server is booting, should UMOD/Oxide be updated with a fresh copy
RUST_SERVER_UPDATE_ON_START | true | When server is booting, should Rust game files be updated 
RUST_SERVER_VALIDATE_ON_START | false | When server is booting, should Rust game files be validated
RUST_SERVER_WIPE_MAP | false | When server is booting, should MAP files get wiped
RUST_SERVER_WIPE_PLAYERS | false | When server is booting, should Player files get wiped
RUST_SERVER_WIPE_ALL | false | When server is booting, should all data be wiped