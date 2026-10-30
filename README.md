# Motorola Camera 4 (MotCamera4) Standalone Vendor Tree

This repository provides a standalone, drop-in vendor tree for **Motorola Camera 4 (MotCamera4)** and its supporting Motorola services, compatible with Android 14 / Android 15 / LineageOS / AOSP-based custom ROMs.

---

## 📦 What's Included

* **Camera Applications**:
  * **`MotCamera4`** (`com.motorola.camera3`): Motorola Camera application with full hardware support for photo, video, pro mode, night vision, macro, portrait, dual capture, and slow motion.
  * **`MotCamera3AI`** (`com.motorola.camera3.content.ai`): Motorola Camera AI content service providing smart composition, scene detection, auto-smile capture, and gesture selfie.
* **Motorola Signature Verification Suite**:
  * **`MotoSignatureApp`** & **`MotoSignature2App`**: Motorola platform signature services.
  * **`com.motorola.motosignature.jar`**: Framework library that verifies pre-signed Motorola applications against original OEM keys.
  * Preserved using `presigned: true` so all signature checks pass without requiring signature spoofing.
* **Permissions, Features & Sysconfig**:
  * Privapp permissions for `com.motorola.camera3`.
  * Feature manifests: `com.motorola.camera3.xml`, `com.motorola.camera3.fogos.xml`, `com.motorola.camera3.content.ai.xml`, `com.motorola.camera3.lens.xml`.
  * Hidden API whitelist and package stopped state exemptions for Android 14/15 compatibility.
  * Init script for Google Lens integration (`init.motcamera3.lens.rc`).
* **Settings & Overlays**:
  * `MotoSettingsProviderOverlayDPPCamera`: Device provisioning settings overlay.
  * `motsettings`: Shell utility for Motorola configuration properties.
* **Hardware & Qualcomm AUX Camera Properties**:
  * Configured properties for Qualcomm camera HALs to expose AUX/macro lenses and whitelist package access.

---

## 🛠️ How to Set Up

### Step 1: Install Git LFS (Prerequisite)

Because `MotCamera4.apk` is ~228 MB, it is tracked via **Git LFS** to avoid GitHub's 100 MB limit while keeping native libraries uncompressed and OEM signatures intact.

Ensure Git LFS is installed on your build machine before syncing:

```bash
# Ubuntu / Debian
sudo apt-get install git-lfs
git lfs install
```

---

### Step 2: Add to ROM Source Tree

Choose one of the following methods to add the tree to your ROM workspace:

#### Method A: Using Local Manifest (Recommended)

Create a manifest file at `.repo/local_manifests/motocam.xml` in your Android build root:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project path="vendor/motorola/camera"
             name="project-moon-gazer/vendor_motorola_camera"
             remote="github"
             revision="main"
             clone-depth="1" />
</manifest>
```

Then sync and pull the LFS objects:

```bash
repo sync vendor/motorola/camera
git -C vendor/motorola/camera lfs pull
```

#### Method B: Manual Git Clone

Clone directly into `vendor/motorola/camera`:

```bash
git clone git@github.com:project-moon-gazer/vendor_motorola_camera.git vendor/motorola/camera --depth=1
cd vendor/motorola/camera
git lfs pull
cd ../../..
```

> [!IMPORTANT]
> Verify that `MotCamera4.apk` is ~228 MB and not a small pointer text file:
> ```bash
> ls -lh vendor/motorola/camera/proprietary/product/priv-app/MotCamera4/MotCamera4.apk
> ```

---

### Step 3: Configure Device Tree

#### A. Inherit Camera Makefile
In your device's product makefile (e.g. `device/motorola/<device>/device.mk`):

```make
# Motorola Camera
$(call inherit-product, vendor/motorola/camera/camera.mk)
```

#### B. Add Soong Namespace
Ensure `vendor/motorola/camera` is included in `PRODUCT_SOONG_NAMESPACES`:

```make
PRODUCT_SOONG_NAMESPACES += \
    vendor/motorola/camera
```

#### C. Add Camera Specifications in `product.prop` (Optional)
To display rear and front camera megapixels accurately on the "About Phone" detailed specs card:

```properties
# Camera specifications
ro.camera.rear=50 MP + 2 MP
ro.camera.front=16 MP
```

---

### Step 4: Build

You can test-build the camera module individually or compile your complete ROM:

```bash
# Set up build environment
source build/envsetup.sh
lunch <your_device>-user

# Build camera module
m MotCamera4

# Or build the full ROM package
brunch <device>
```

---

## ⚙️ Exported Camera Properties

When `camera.mk` is inherited, the following vendor properties are automatically exported:

```properties
persist.vendor.camera.expose.aux=1
persist.vendor.camera.physical.num=3
persist.vendor.camera.privapp.list=org.codeaurora.snapcam,com.motorola.camera3
vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.motorola.camera3,com.motorola.camera5,com.motorola.motocit
vendor.camera.aux.packagelist2=com.motorola.ccc,com.android.settings,com.motorola.motointelligence
ro.camera.cfa.packagelist=com.motorola.coresettingsext,com.motorola.camera2,com.motorola.camera3,com.motorola.actions
ro.vendor.camera.noiseVibratortime=180
```

---

## 🔧 Device-Specific Customization

* **Device Feature Manifest**:
  The default package includes `com.motorola.camera3.fogos.xml`. For other Motorola devices (e.g. `rhode`, `penang`, `borzoi`), copy your device's stock `com.motorola.camera3.<device>.xml` into `proprietary/product/etc/permissions/` and reference it in `camera.mk`.
* **Aperture / Default Camera Overrides**:
  `MotCamera4` is configured in `Android.bp` with `overrides: ["Aperture", "Camera", "Camera2", "GoogleCameraGo", "GCamGOPrebuilt"]` to automatically replace AOSP / LineageOS stock camera apps when included.

---

## ❓ Troubleshooting & FAQ

#### 1. Build fails with `ZipException` or APK cannot be parsed:
* **Cause**: `MotCamera4.apk` is still a Git LFS text pointer (~130 bytes) instead of the actual 228 MB binary.
* **Solution**: Run `git lfs install && git -C vendor/motorola/camera lfs pull`.

#### 2. App crashes with `SecurityException` or signature check failure:
* **Cause**: The APK was re-signed with ROM test/platform keys.
* **Solution**: Motorola Camera requires original OEM signature verification via `com.motorola.motosignature.jar`. Keep `presigned: true` in `Android.bp`.

#### 3. Macro / AUX lens is not accessible or switching is slow:
* **Cause**: The camera package name is missing from Qualcomm AUX camera whitelists.
* **Solution**: Ensure `vendor/motorola/camera/camera.mk` is inherited in your device makefile so `vendor.camera.aux.packagelist` is set properly.

---

## 📜 Credits & License

* Motorola Mobility LLC for the proprietary binaries and libraries.
* The LineageOS Project for Android build system integration conventions.
