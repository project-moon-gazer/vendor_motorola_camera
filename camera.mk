#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

CAMERA_PATH := vendor/motorola/camera

# Soong Namespace
PRODUCT_SOONG_NAMESPACES += \
    $(CAMERA_PATH)

# Permissions, Features & Sysconfig
PRODUCT_COPY_FILES += \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/privapp-permissions-com.motorola.camera3.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-com.motorola.camera3.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/com.motorola.camera3.fogos.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.motorola.camera3.fogos.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/com.motorola.camera3.content.ai.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.motorola.camera3.content.ai.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/com.motorola.camera3.lens.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.motorola.camera3.lens.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/com.motorola.camera3.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.motorola.camera3.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/com.motorola.moto-uirefresh.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.motorola.moto-uirefresh.xml \
    $(CAMERA_PATH)/proprietary/product/etc/permissions/deviceowner-configuration-com.motorola.camera3.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/deviceowner-configuration-com.motorola.camera3.xml \
    $(CAMERA_PATH)/proprietary/product/etc/sysconfig/hiddenapi-whitelist-com.motorola.camera3.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/hiddenapi-whitelist-com.motorola.camera3.xml \
    $(CAMERA_PATH)/proprietary/product/etc/sysconfig/initial-package-stopped-states-com.motorola.camera3.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/initial-package-stopped-states-com.motorola.camera3.xml \
    $(CAMERA_PATH)/proprietary/product/etc/init/init.motcamera3.lens.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.motcamera3.lens.rc \
    $(CAMERA_PATH)/proprietary/product/etc/MotoDesktopAppConfig/com.motorola.camera3.desktop-config.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/MotoDesktopAppConfig/com.motorola.camera3.desktop-config.xml \
    $(CAMERA_PATH)/proprietary/system/etc/permissions/com.motorola.motosignature.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.motosignature.xml

# Properties
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.expose.aux=1 \
    persist.vendor.camera.physical.num=3 \
    persist.vendor.camera.privapp.list=org.codeaurora.snapcam,com.motorola.camera3 \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.motorola.camera3,com.motorola.camera5,com.motorola.motocit \
    vendor.camera.aux.packagelist2=com.motorola.ccc,com.android.settings,com.motorola.motointelligence \
    ro.camera.cfa.packagelist=com.motorola.coresettingsext,com.motorola.camera2,com.motorola.camera3,com.motorola.actions \
    ro.vendor.camera.noiseVibratortime=180

# Packages
PRODUCT_PACKAGES += \
    MotCamera4 \
    MotCamera3AI \
    MotoSignatureApp \
    MotoSignature2App \
    com.motorola.motosignature \
    motsettings \
    MotoSettingsProviderOverlayDPPCamera
