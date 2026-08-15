#!/bin/bash
# Package Pronunciation Workshop into local, double-click apps for mac/win/linux.
# Each package bundles the Go launcher binary + app/ (UI) + MP4/ (videos) → fully offline.
# Usage:  ./build.sh [mac|win|linux|all]
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
B="$HERE/build"; DIST="$HERE/dist"
APPNAME="Pronunciation Workshop"
GUIDE_PDF="$HERE/HUONG-DAN-SU-DUNG.pdf"
GUIDE_MD="$HERE/HUONG-DAN-SU-DUNG.md"
mkdir -p "$DIST"
TARGET="${1:-all}"

# rebuild binaries
echo "› building binaries…"
( cd "$HERE/src"
  GOOS=darwin  GOARCH=arm64 go build -ldflags "-s -w" -o "$B/pw-darwin-arm64" launcher.go
  GOOS=darwin  GOARCH=amd64 go build -ldflags "-s -w" -o "$B/pw-darwin-amd64" launcher.go
  GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o "$B/pw-windows-amd64.exe" launcher.go
  GOOS=linux   GOARCH=amd64 go build -ldflags "-s -w" -o "$B/pw-linux-amd64" launcher.go )
lipo -create -output "$B/pw-darwin-universal" "$B/pw-darwin-arm64" "$B/pw-darwin-amd64" 2>/dev/null || cp "$B/pw-darwin-arm64" "$B/pw-darwin-universal"

copy_content() { # $1 = destination dir that will hold app/ and MP4/
  mkdir -p "$1"
  cp -R "$ROOT/app" "$1/app"
  cp -R "$ROOT/MP4" "$1/MP4"
}

build_mac() {
  echo "› macOS .app + .dmg…"
  local APP="$DIST/$APPNAME.app"
  rm -rf "$APP"
  mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
  cp "$B/pw-darwin-universal" "$APP/Contents/MacOS/$APPNAME"
  chmod +x "$APP/Contents/MacOS/$APPNAME"
  cp "$HERE/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
  copy_content "$APP/Contents/Resources"
  cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>$APPNAME</string>
  <key>CFBundleDisplayName</key><string>$APPNAME</string>
  <key>CFBundleIdentifier</key><string>com.pronunciationworkshop.local</string>
  <key>CFBundleVersion</key><string>1.0</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleExecutable</key><string>$APPNAME</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>LSMinimumSystemVersion</key><string>10.13</string>
  <key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
  # DMG (drag-to-install feel) — stage the .app + the user guide together
  local STAGE="$DIST/.dmg-stage"
  rm -rf "$STAGE"; mkdir -p "$STAGE"
  cp -R "$APP" "$STAGE/"
  [ -f "$GUIDE_PDF" ] && cp "$GUIDE_PDF" "$STAGE/Hướng dẫn sử dụng.pdf"
  rm -f "$DIST/PronunciationWorkshop-mac.dmg"
  hdiutil create -volname "$APPNAME" -srcfolder "$STAGE" -ov -format UDZO \
    "$DIST/PronunciationWorkshop-mac.dmg" >/dev/null
  rm -rf "$STAGE"
  echo "  → $DIST/PronunciationWorkshop-mac.dmg"
}

build_win() {
  echo "› Windows folder + zip…"
  local D="$DIST/PronunciationWorkshop-win"
  rm -rf "$D"; mkdir -p "$D"
  cp "$B/pw-windows-amd64.exe" "$D/$APPNAME.exe"
  copy_content "$D"
  [ -f "$GUIDE_PDF" ] && cp "$GUIDE_PDF" "$D/Hướng dẫn sử dụng.pdf"
  [ -f "$GUIDE_MD" ] && cp "$GUIDE_MD" "$D/Hướng dẫn sử dụng.md"
  printf 'Double-click "%s.exe" to start. Allow it through Windows SmartScreen (More info → Run anyway).\r\nXem "Huong dan su dung.pdf" de biet cach dung.\r\n' "$APPNAME" > "$D/READ ME.txt"
  ( cd "$DIST" && rm -f PronunciationWorkshop-win.zip && zip -rq PronunciationWorkshop-win.zip "PronunciationWorkshop-win" )
  echo "  → $DIST/PronunciationWorkshop-win.zip"
}

build_linux() {
  echo "› Linux folder + tar.gz…"
  local D="$DIST/PronunciationWorkshop-linux"
  rm -rf "$D"; mkdir -p "$D"
  cp "$B/pw-linux-amd64" "$D/PronunciationWorkshop"
  chmod +x "$D/PronunciationWorkshop"
  copy_content "$D"
  [ -f "$GUIDE_PDF" ] && cp "$GUIDE_PDF" "$D/Huong-dan-su-dung.pdf"
  [ -f "$GUIDE_MD" ] && cp "$GUIDE_MD" "$D/Huong-dan-su-dung.md"
  printf 'Run ./PronunciationWorkshop (or double-click → Run). Needs xdg-open for auto browser launch.\nSee "Huong-dan-su-dung.pdf" for usage.\n' > "$D/READ ME.txt"
  ( cd "$DIST" && rm -f PronunciationWorkshop-linux.tar.gz && tar -czf PronunciationWorkshop-linux.tar.gz "PronunciationWorkshop-linux" )
  echo "  → $DIST/PronunciationWorkshop-linux.tar.gz"
}

case "$TARGET" in
  mac) build_mac ;;
  win) build_win ;;
  linux) build_linux ;;
  all) build_mac; build_win; build_linux ;;
  *) echo "usage: ./build.sh [mac|win|linux|all]"; exit 1 ;;
esac
echo "✓ done → $DIST"
