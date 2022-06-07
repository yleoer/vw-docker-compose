#!/usr/bin/env bash

local_path='/opt/vaultwarden'
remote_path='oss://backup-yleoer/vaultwarden'

function initFun() {
  cd $local_path || exit 1

  backup_path="./backup/$(date +%y%m)"
  mkdir -p "$backup_path"

  backup_filename="vaultwarden-$(date +%y%d%H%M).tar.gz"
  zip_filename="$backup_path/$backup_filename"
  remote_filename="$remote_path/$backup_filename"
}

function backupFun() {
    docker-compose stop
    tar -zcvf "$zip_filename" data

    # 上传数据
    ossutil cp "$zip_filename" "$remote_filename"

    docker-compose start
}

initFun
backupFun