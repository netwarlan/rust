#!/usr/bin/env bas

echo "
╔═══════════════════════════════════════════════╗
║                                               ║
║       _  _____________      _____   ___       ║
║      / |/ / __/_  __/ | /| / / _ | / _ \      ║
║     /    / _/  / /  | |/ |/ / __ |/ , _/      ║
║    /_/|_/___/ /_/   |__/|__/_/ |_/_/|_|       ║
║                                 OFFICIAL      ║
║                                               ║
╠═══════════════════════════════════════════════╣
║ Thanks for using our DOCKER image! Should you ║
║ have issues, please reach out or create a     ║
║ github issue. Thanks!                         ║
║                                               ║
║ For more information:                         ║
║ github.com/netwarlan                          ║
╚═══════════════════════════════════════════════╝"


## Set default values if none were provided
## ==============================================
[[ -z "${RUST_SERVER_NAME}" ]] && RUST_SERVER_NAME="Docker Rust"
[[ -z "${RUST_SERVER_DESCRIPTION}" ]] && RUST_SERVER_DESCRIPTION="This Rust server is going to be awesome!"
[[ -z "${RUST_SERVER_PORT}" ]] && RUST_SERVER_PORT="28015"
[[ -z "${RUST_SERVER_LEVEL}" ]] && RUST_SERVER_LEVEL="Procedural Map"
[[ -z "${RUST_SERVER_IDENTITY}" ]] && RUST_SERVER_IDENTITY="rust"
[[ -z "${RUST_SERVER_SEED}" ]] && RUST_SERVER_SEED="12345"
[[ -z "${RUST_SERVER_WORLDSIZE}" ]] && RUST_SERVER_WORLDSIZE="3000"
[[ -z "${RUST_SERVER_MAXPLAYERS}" ]] && RUST_SERVER_MAXPLAYERS="100"
[[ -z "${RUST_SERVER_URL}" ]] && RUST_SERVER_URL="https://netwar.org"
[[ -z "${RUST_SERVER_HEADER_IMAGE}" ]] && RUST_SERVER_HEADER_IMAGE="https://www.netwar.org/wp-content/uploads/2018/01/Netwar_Logo.png"
[[ -z "${RUST_SERVER_SAVE_INTERVAL}" ]] && RUST_SERVER_SAVE_INTERVAL="300"
[[ -z "${RUST_RCON_ENABLE}" ]] && RUST_RCON_ENABLE=false
[[ -z "${RUST_RCON_PORT}" ]] && RUST_RCON_PORT="28016"
[[ ! -z "${RUST_RCON_PASSWORD}" ]] && RUST_RCON_PASSWORD=""
[[ -z "${RUST_UMOD_ENABLED}" ]] && RUST_UMOD_ENABLED=false
[[ -z "${RUST_UMOD_UPDATE_ON_BOOT}" ]] && RUST_UMOD_UPDATE_ON_BOOT=false
[[ -z "${RUST_SERVER_UPDATE_ON_START}" ]] && RUST_SERVER_UPDATE_ON_START=true
[[ -z "${RUST_SERVER_VALIDATE_ON_START}" ]] && RUST_SERVER_VALIDATE_ON_START=false



## Update on startup
## ==============================================
if [[ "${RUST_SERVER_UPDATE_ON_START}" = true ]] || [[ "${RUST_SERVER_VALIDATE_ON_START}" = true ]]; then
echo "
╔═══════════════════════════════════════════════╗
║ Checking for updates                          ║
╚═══════════════════════════════════════════════╝"
  if [[ "${RUST_SERVER_VALIDATE_ON_START}" = true ]]; then
    VALIDATE_FLAG='validate'
    echo "- Validating"
  else
    VALIDATE_FLAG=''
  fi

  ${STEAMCMD_DIR}/steamcmd.sh \
  +force_install_dir ${GAME_DIR} \
  +login ${STEAMCMD_USER} ${STEAMCMD_PASSWORD} ${STEAMCMD_AUTH_CODE} \
  +app_update ${STEAMCMD_APP} ${VALIDATE_FLAG} \
  +quit
fi




## Setting up environment
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Setting up environment                        ║
╚═══════════════════════════════════════════════╝"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GAME_DIR}/RustDedicated_Data/Plugins/x86_64




## Check if UMOD is needed
## ==============================================
if [[ "${RUST_UMOD_ENABLED}" = true ]]; then
  echo "
╔═══════════════════════════════════════════════╗
║ Installing/Updating UMOD                      ║
╚═══════════════════════════════════════════════╝"
  echo "- Downloading and installing latest Oxide"
  OXIDE_URL="https://umod.org/games/rust/download/develop"
  curl -sL ${OXIDE_URL} -o ${GAME_DIR}/oxide.zip
  unzip -o ${GAME_DIR}/oxide.zip -d ${GAME_DIR}
  rm ${GAME_DIR}/oxide.zip
fi





## Check if RCON is needed
## ==============================================
if [[ "${RUST_RCON_ENABLE}" = true ]]; then
  if [[ ! -z "${RUST_RCON_PORT}" ]] && [[ ! -z "${RUST_RCON_PASSWORD}" ]]; then
echo "
╔═══════════════════════════════════════════════╗
║ Enabling RCON                                 ║
╚═══════════════════════════════════════════════╝"
    echo "- Setting up RCON"
    RUST_RCON_COMMAND="+rcon.port ${RUST_RCON_PORT} +rcon.password ${RUST_RCON_PASSWORD}"
    echo "- Setup completed."
  fi
fi




## Flatten permissions
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Flatten Permissions                           ║
╚═══════════════════════════════════════════════╝"
echo "- Level setting permissions"
chown ${GAME_USER}:${GAME_USER} -R ${GAME_DIR}
chmod 770 -R ${GAME_DIR}
echo "- Level set complete."






## Starting server
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Starting SERVER                               ║
╚═══════════════════════════════════════════════╝"
cd ${GAME_DIR}
unbuffer ./RustDedicated -batchmode -nographics \
+server.port "${RUST_SERVER_PORT}" \
+server.hostname "${RUST_SERVER_NAME}" \
+server.level "${RUST_SERVER_LEVEL}" \
+server.description "${RUST_SERVER_DESCRIPTION}" \
+server.url "${RUST_SERVER_URL}" \
+server.headerimage "${RUST_SERVER_HEADER_IMAGE}" \
+server.identity "${RUST_SERVER_IDENTITY}" \
+server.maxplayers "${RUST_SERVER_MAXPLAYERS}" \
+server.worldsize "${RUST_SERVER_WORLDSIZE}" \
+server.seed "${RUST_SERVER_SEED}" \
+server.saveinterval "${RUST_SERVER_SAVE_INTERVAL}" \
2>&1 | grep --line-buffered -Ev '^\s*$|Filename' | tee ${GAME_DIR}/logs/${RUST_SERVER_IDENTITY}_logs.txt
