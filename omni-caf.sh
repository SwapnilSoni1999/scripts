#!/bin/bash

source $HOME/omni/build/envsetup.sh
croot

rm -rf external/tinycompress
git clone https://github.com/PixelExperience-P/external_tinycompress.git -b pie external/tinycompress
rm -rf external/ebtables
git clone https://github.com/PixelExperience-P/external_ebtables.git -b pie external/ebtables

rm -rf external/ant-wireless/ant_service
rm -rf external/ant-wireless/antradio-library
rm -rf external/ant-wireless/ant_native

git clone https://github.com/PixelExperience-P/external_ant-wireless_ant_service -b pie external/ant-wireless/ant_service
git clone https://github.com/PixelExperience-P/external_ant-wireless_antradio-library -b pie external/ant-wireless/antradio-library
git clone https://github.com/PixelExperience-P/external_ant-wireless_ant_native -b pie external/ant-wireless/ant_native

rm -rf hardware/qcom/audio-caf/msm8996
rm -rf hardware/qcom/display-caf/msm8996
rm -rf hardware/qcom/media-caf/msm8996

git clone https://github.com/RiteshSaxena/hardware_qcom_display -b pie-caf-8996 hardware/qcom/display-caf/msm8996
git clone https://github.com/RiteshSaxena/hardware_qcom_audio -b pie-caf-8996 hardware/qcom/audio-caf/msm8996
git clone https://github.com/RiteshSaxena/hardware_qcom_media -b pie-caf-8996 hardware/qcom/media-caf/msm8996

rm -rf external/perfetto
git clone https://github.com/PixelExperience-P/external_perfetto -b pie external/perfetto

rm -rf hardware/qcom/bt-caf
rm -rf hardware/qcom/wlan-caf
git clone https://github.com/PixelExperience-P/hardware_qcom_bt.git -b pie-caf hardware/qcom/bt-caf
git clone https://github.com/PixelExperience-P/hardware_qcom_wlan.git  -b pie-caf hardware/qcom/wlan-caf

rm -rf hardware/ril-caf
git clone https://github.com/PixelExperience-P/hardware_ril.git -b pie-caf hardware/ril-caf


git clone https://github.com/LineageOS/android_vendor_qcom_opensource_interfaces -b lineage-16.0 vendor/qcom/opensource/interfaces
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_dataservices -b lineage-16.0 vendor/qcom/opensource/android_vendor_qcom_opensource_dataservices
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_audio -b lineage-16.0 vendor/qcom/opensource/audio-caf

if [[ ! -d system/qcom ]]; then
	git clone https://github.com/PixelExperience-P/system_qcom -b pie system/qcom	
fi

croot
if [[ ! -d device/xiaomi/msm8953-common ]]; then
	git clone https://github.com/TheScarastic/android_device_xiaomi_msm8953-common -b lineage-16.0 device/xiaomi/msm8953-common	
fi
if [[ ! -d device/xiaomi/mido ]]; then
	git clone https://github.com/TheScarastic/android_device_xiaomi_mido -b lineage-16.0 device/xiaomi/mido 	
fi
if [[ ! -d kernel/xiaomi/msm8953 ]]; then
	git clone https://github.com/TheScarastic/android_kernel_xiaomi_msm8953 -b lineage-15.1-treble kernel/xiaomi/msm8953 	
fi
if [[ ! -d vendor/xiaomi ]]; then
	git clone https://github.com/TheScarastic/proprietary_vendor_xiaomi -b lineage-16.0 vendor/xiaomi	
fi

# Merge frameworks stuff
cd $HOME/omni/frameworks/native 

git fetch https://github.com/PixelExperience-P/frameworks_native pie 
git cherry-pick 911a39edc9356ec63a2f84f530bbf65a6da7810a^..d4dc135e3f8ff8cd824786666e239eb489b601e5

croot

#merge bionic
cd $HOME/omni/bionic 
git fetch https://github.com/PixelExperience-P/bionic.git pie 
git cherry-pick 067774cb3f49b80f4d9bd7fc488c7e15c1151e90^..53cb94ec41f463a6e7c0e2d857b7d52342ab838f
git cherry-pick 34b8be6662365e6ca98859bd990cec8b54cad335^..57fc114e0d3f38b5d97ba4011af7f196096ff1eb

croot

# lunch mido

lunch omni_mido-userdebug

