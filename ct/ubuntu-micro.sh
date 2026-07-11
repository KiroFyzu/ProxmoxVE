#!/usr/bin/env bash

source <(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)

# Copyright (c) 2021-2026 tteck
# License: MIT
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
var_unprivileged="1"
var_arm64="yes"


# ==========================
# Auto CT ID
# ==========================

NEXT_ID=$(pvesh get /cluster/nextid)

if [[ -z "$NEXT_ID" ]]; then
    NEXT_ID=100
fi

var_ctid="$NEXT_ID"


# ==========================
# Auto Hostname
# ==========================

var_hostname="ubuntu-micro-${var_ctid}"


# ==========================
# Informasi Paket
# ==========================

header_info "$APP"

echo -e "
====================================
 Paket LXC : Ubuntu Micro
------------------------------------
 CT ID     : $var_ctid
 Hostname  : $var_hostname
 CPU       : 1 Core
 RAM       : 2048 MB
 SSD       : 15 GB
 OS        : Ubuntu 24.04
 Type      : Unprivileged
====================================
"


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
# Build
# ==========================

start


# Override default values

export CTID="$var_ctid"
export HOSTNAME="$var_hostname"

export var_cpu="1"
export var_ram="2048"
export var_disk="15"


build_container


description


msg_ok "Completed successfully!"

echo -e "

${GN}${APP} created successfully!${CL}

CT ID     : ${var_ctid}
Hostname  : ${var_hostname}
CPU       : 1 Core
RAM       : 2 GB
Disk      : 15 GB

"
