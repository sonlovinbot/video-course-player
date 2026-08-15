#!/bin/bash
# Double-click to launch Pronunciation Workshop locally (mic recording needs localhost).
cd "$(dirname "$0")/.."
PORT=8123
# kill any old server on the port, then start the range-capable server
lsof -ti:$PORT | xargs kill -9 2>/dev/null
python3 .claude/serve.py $PORT >/dev/null 2>&1 &
sleep 1
open "http://localhost:$PORT/app/index.html"
echo "Pronunciation Workshop đang chạy tại http://localhost:$PORT/app/index.html"
echo "Đóng cửa sổ này để tắt server."
wait
