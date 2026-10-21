#!/bin/zsh
set -eu
cd -- "${0:A:h}"
export PATH="/Users/tong/.docker/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"
docker compose stop
echo "白板已停止。已导出的绘图文件不会受到影响。"
