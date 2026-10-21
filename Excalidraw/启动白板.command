#!/bin/zsh
set -eu
cd -- "${0:A:h}"
export PATH="/Users/tong/.docker/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

if ! docker info >/dev/null 2>&1; then
  open /Applications/Docker.app
  echo "正在等待 Docker 启动……"
  for attempt in {1..30}; do
    if docker info >/dev/null 2>&1; then break; fi
    sleep 2
  done
fi

if ! docker compose up -d; then
  echo "启动失败，请检查 Docker 是否已经运行。"
  read "?按回车关闭窗口。"
  exit 1
fi

for attempt in {1..30}; do
  if curl -fsS --max-time 2 http://127.0.0.1:8787/ >/dev/null; then
    open http://localhost:8787
    exit 0
  fi
  sleep 1
done
echo "白板尚未就绪，请检查 Docker 中的 excalidraw 服务。"
read "?按回车关闭窗口。"
exit 1
