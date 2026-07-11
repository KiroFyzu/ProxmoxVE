#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/KiroFyzu/ProxmoxVE/refs/heads/main/misc/build.func)
# Copyright (c) 2021-2026 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://ubuntu.com/

APP="Ubuntu Micro"

# ==========================
# Paket LXC Micro
# ==========================
var_tags="micro,ubuntu"

var_cpu="1"
var_ram="2048"
var_disk="15"

var_os="ubuntu"
var_version="24.04"
var_arch="amd64"
var_arm64="yes"

# LXC unprivileged
var_unprivileged="1"


header_info "$APP"

color
catch_errors


# ==========================
# Update Container
# ==========================
function update_script() {
  header_info

  check_container_storage
  check_container_resources

  if [[ ! -d /var ]]; then
    msg_error "No ${APP} Installation Found!"
    exit
  fi

  msg_info "Updating ${APP} LXC"

  $STD apt-get update
  $STD apt-get -y upgrade

  msg_ok "Updated ${APP} LXC"
  exit
}


# ==========================
# Build Container
# ==========================

start


# Override resource agar tetap paket Micro
CPU_CORES=1
RAM_SIZE=2048
DISK_SIZE=15


export var_cpu="$CPU_CORES"
export var_ram="$RAM_SIZE"
export var_disk="$DISK_SIZE"


build_container


description


msg_ok "Completed successfully!\n"

echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"

echo ""
echo "======================================"
echo " Paket LXC : Ubuntu Micro"
echo " CPU       : 1 Core"
echo " RAM       : 2 GB"
echo " SSD       : 15 GB"
echo " OS        : Ubuntu 24.04"
echo "======================================"
