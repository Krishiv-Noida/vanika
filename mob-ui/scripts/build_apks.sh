#!/usr/bin/env bash
set -euo pipefail

# Script to build APKs for each platform architecture (ABIs) and Universal APK
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_DIR"

echo "=========================================="
echo "  🌿 Vanika Mobile - Build Multi-Platform APKs"
echo "=========================================="

BUILD_MODE="${1:-release}"
echo "Build Mode: $BUILD_MODE"
echo ""

# Ensure dependencies
echo "📦 Running flutter pub get..."
flutter pub get

# 1. Build Split APKs per ABI (armeabi-v7a, arm64-v8a, x86_64)
echo ""
echo "🚀 Building split APKs for each architecture (armeabi-v7a, arm64-v8a, x86_64)..."
flutter build apk --split-per-abi --"$BUILD_MODE"

# 2. Build Universal APK
echo ""
echo "🌍 Building Universal APK (contains all architectures)..."
flutter build apk --"$BUILD_MODE"

# 3. Create dist directory and copy artifacts
DIST_DIR="$PROJECT_DIR/dist/apks"
mkdir -p "$DIST_DIR"

OUTPUT_DIR="$PROJECT_DIR/build/app/outputs/flutter-apk"

if [ -f "$OUTPUT_DIR/app-armeabi-v7a-$BUILD_MODE.apk" ]; then
  cp "$OUTPUT_DIR/app-armeabi-v7a-$BUILD_MODE.apk" "$DIST_DIR/vanika-armeabi-v7a.apk"
fi

if [ -f "$OUTPUT_DIR/app-arm64-v8a-$BUILD_MODE.apk" ]; then
  cp "$OUTPUT_DIR/app-arm64-v8a-$BUILD_MODE.apk" "$DIST_DIR/vanika-arm64-v8a.apk"
fi

if [ -f "$OUTPUT_DIR/app-x86_64-$BUILD_MODE.apk" ]; then
  cp "$OUTPUT_DIR/app-x86_64-$BUILD_MODE.apk" "$DIST_DIR/vanika-x86_64.apk"
fi

if [ -f "$OUTPUT_DIR/app-$BUILD_MODE.apk" ]; then
  cp "$OUTPUT_DIR/app-$BUILD_MODE.apk" "$DIST_DIR/vanika-universal.apk"
fi

# Generate checksums
cd "$DIST_DIR"
sha256sum *.apk > SHA256SUMS.txt

echo ""
echo "=========================================="
echo "✅ Build Completed Successfully!"
echo "Artifacts generated in: $DIST_DIR"
echo "=========================================="
ls -lh "$DIST_DIR"
echo ""
echo "Checksums:"
cat "$DIST_DIR/SHA256SUMS.txt"
