# 🌿 Vanika Mobile (`mob-ui`)

A modern mobile application for Vanika e-commerce built with Flutter.

---

## 🚀 CI/CD Pipeline

The project includes an automated GitHub Actions CI/CD pipeline configured at [`.github/workflows/flutter-build-apk.yml`](../.github/workflows/flutter-build-apk.yml).

### Workflow Capabilities:
1. **Automated Testing & Analysis**:
   - Runs on every `push` and `pull_request` targeting `main`/`master` affecting `mob-ui/`.
   - Executes `flutter test` and validates build integrity.

2. **Multi-Platform APK Generation**:
   - Compiles separate APKs optimized for each CPU architecture (split-per-ABI).
   - Generates a universal APK compatible with all Android devices.
   - Builds Google Play-ready Android App Bundles (`.aab`).

3. **Artifact Publishing & Step Summaries**:
   - Uploads all generated APKs and bundles as downloadable GitHub Actions artifacts.
   - Automatically generates a Markdown summary in the GitHub Actions run displaying file sizes, architectures, and SHA-256 checksums.

4. **Automated Releases**:
   - Pushing a version tag (e.g. `v1.0.0`) automatically publishes a GitHub Release with all APK files attached.
   - Supports manual execution via `workflow_dispatch` with custom options (Release vs. Debug, toggle split APKs, Universal APK, or App Bundle).

---

## 📱 Platform Architectures & Generated Artifacts

| Artifact | Target Architecture / Platform | Description |
| :--- | :--- | :--- |
| `vanika-arm64-v8a.apk` | **ARM 64-bit** (`arm64-v8a`) | Optimized for 90%+ of modern Android phones and tablets. Smaller file size, maximum performance. |
| `vanika-armeabi-v7a.apk` | **ARM 32-bit** (`armeabi-v7a`) | Backwards compatibility for older 32-bit Android devices. |
| `vanika-x86_64.apk` | **x86 64-bit** (`x86_64`) | Optimized for Android emulators, ChromeOS devices, and Intel/AMD tablets. |
| `vanika-universal.apk` | **Universal** (Fat APK) | Single installer containing binaries for all ABIs; runs on any Android device. |
| `vanika-release.aab` | **Android App Bundle** | Format required by Google Play Console for dynamic delivery. |

---

## 🛠️ Local Development & Building

### Prerequisites
- Flutter SDK (>= 3.13.5 / stable)
- Java 17 (Eclipse Temurin recommended)
- Android SDK (API 34+ / Build-Tools)

### Quick Local Build Script
To build all platform APKs locally:
```bash
# Make script executable (if needed)
chmod +x ./scripts/build_apks.sh

# Build release APKs for all platforms + universal APK
./scripts/build_apks.sh release
```
All generated APKs and their SHA-256 checksums will be saved to `mob-ui/dist/apks/`.

### Manual Commands
```bash
# Install dependencies
flutter pub get

# Run tests
flutter test

# Build split APKs per ABI platform
flutter build apk --split-per-abi --release

# Build universal APK
flutter build apk --release

# Build App Bundle for Play Store
flutter build appbundle --release
```
