#!/bin/bash
set -e

# Copia APK preinstallati nella cartella device per la build
APK_DIR="$HOME/android/lineage/prebuilt/apps"

mkdir -p "$APK_DIR"
# Qui puoi aggiungere i comandi per scaricare o copiare gli APK (microG, Aurora, Firefox)

# Esempio: scarica APK da URL e li mette nella cartella
wget -q -O "$APK_DIR/GmsCore.apk" https://microg.org/fdroid/repo/org.microg.gms.droidguard.apk
wget -q -O "$APK_DIR/AuroraStore.apk" https://f-droid.org/repo/com.aurora.store_4.3.2.apk
wget -q -O "$APK_DIR/Fennec.apk" https://f-droid.org/repo/org.mozilla.fennec_fdroid.apk

# Modifica il file device.mk per aggiungere i package
DEVICE_MK="$HOME/android/lineage/device/generic/goldfish/lineage_x86_64.mk"

if ! grep -q "PRODUCT_PACKAGES += AuroraStore" "$DEVICE_MK"; then
  echo -e "\nPRODUCT_PACKAGES += \\\n    AuroraStore \\\n    Fennec \\\n    GmsCore" >> "$DEVICE_MK"
fi

echo "Prebuilt APKs aggiunti con successo."