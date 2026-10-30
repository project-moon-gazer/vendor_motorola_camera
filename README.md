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

## 🚀 Integration Guide

### 1. Include in Device Tree

In your device makefile (e.g. `device/<oem>/<device>/device.mk` or `device.mk`):

```make
# Motorola Camera
$(call inherit-product, vendor/motorola/camera/camera.mk)
```

Ensure `vendor/motorola/camera` is present in `PRODUCT_SOONG_NAMESPACES`:

```make
PRODUCT_SOONG_NAMESPACES += \
    vendor/motorola/camera
```

---

### 2. Git LFS Requirement

Due to uncompressed 64-bit native libraries inside `MotCamera4.apk` (~228 MB), this file is tracked via **Git LFS** to adhere to GitHub's 100 MB file limit while preserving original Motorola signature integrity.

When syncing or cloning the repository:

```bash
# Ensure git-lfs is installed
git lfs install

# Pull the large prebuilt binaries
git lfs pull
```

In your ROM's manifest XML:

```xml
<project path="vendor/motorola/camera" name="project-moon-gazer/vendor_motorola_camera" remote="github" revision="main" />
```

---

### 3. Camera Properties (`camera.mk`)

The following vendor properties are automatically exported by `camera.mk`:

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

## 📜 Credits & License

* Motorola Mobility LLC for the proprietary binaries and libraries.
* The LineageOS Project for Android build system integration conventions.
