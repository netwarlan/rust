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

Environment Variable | Default Value
-------------------- | -------------
RUST_SERVER_NAME | Docker Rust
RUST_SERVER_DESCRIPTION | This Rust server is going to be awesome!
RUST_SERVER_PORT | 28015
RUST_APP_PORT | 28082
RUST_SERVER_LEVEL | Procedural Map
RUST_SERVER_IDENTITY | rust
RUST_SERVER_SEED | 12345
RUST_SERVER_WORLDSIZE | 3000
RUST_SERVER_MAXPLAYERS | 100
RUST_SERVER_URL | https://netwar.org
RUST_SERVER_HEADER_IMAGE | https://www.netwar.org/wp-content/uploads/2018/01/Netwar_Logo.png
RUST_SERVER_SAVE_INTERVAL | 300 
RUST_RCON_ENABLE | false
RUST_RCON_PORT | 28016
RUST_RCON_PASSWORD | n/a
RUST_UMOD_ENABLED | false
RUST_UMOD_UPDATE_ON_BOOT | false
RUST_SERVER_UPDATE_ON_START | true
RUST_SERVER_VALIDATE_ON_START | false