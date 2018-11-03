#!/bin/bash

source build/envsetup.sh
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

git clone https://github.com/zeelog/android_device_xiaomi_mido.git -b lineage-16.0 device/xiaomi/mido
git clone https://github.com/zeelog/android_kernel_xiaomi_msm8953.git -b lineage-16.0 kernel/xiaomi/msm8953
git clone https://github.com/zeelog/proprietary_vendor_xiaomi.git -b lineage-16.0 vendor/xiaomi

git clone https://github.com/LineageOS/android_vendor_qcom_opensource_audio -b lineage-16.0 vendor/qcom/opensource/audio
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_dataservices -b lineage-16.0 vendor/qcom/opensource/dataservices
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_interfaces -b lineage-16.0 vendor/qcom/opensource/interfaces
git clone https://github.com/PixelExperience-P/system_qcom -b pie system/qcom

# Merge frameworks stuff
cd $HOME/omni/frameworks/native
git fetch https://github.com/PixelExperience-P/frameworks_native pie
git cherry-pick 911a39edc9356ec63a2f84f530bbf65a6da7810a^..d4dc135e3f8ff8cd824786666e239eb489b601e5
croot

#merge bionic
#cd $HOME/omni/bionic
#git fetch https://github.com/PixelExperience-P/bionic.git pie
#git cherry-pick 067774cb3f49b80f4d9bd7fc488c7e15c1151e90^..53cb94ec41f463a6e7c0e2d857b7d52342ab838f
#git cherry-pick 34b8be6662365e6ca98859bd990cec8b54cad335^..57fc114e0d3f38b5d97ba4011af7f196096ff1eb
#croot


#project path for mido+hals

cd device/xiaomi/mido/camera/Q*

sed -i "s|\$(call project-path-for,qcom-media)|hardware\/qcom\/media-caf\/msm8996|g" Android.mk
sed -i "s|\$(call project-path-for,qcom-display)|hardware\/qcom\/display-caf\/msm8996|g" Android.mk

croot
#cd $HOME/omni/hardware/qcom/audio-caf/msm8996
#find . -name '*.mk' -exec grep -i 'call project' {} \; -print -exec sed -i "s|\$(call project-path-for,qcom-audio)|hardware\/qcom\/audio-caf\/msm8996|g" {} \;

#cd $HOME/omni/hardware/qcom/display-caf/msm8996
#find . -name '*.mk' -exec grep -i 'call project' {} \; -print -exec sed -i "s|\$(call project-path-for,qcom-display)|hardware\/qcom\/display-caf\/msm8996|g" {} \;

#cd $HOME/omni/hardware/qcom/media-caf/msm8996
#find . -name '*.mk' -exec grep -i 'call project' {} \; -print -exec sed -i "s|\$(call project-path-for,qcom-media)|hardware\/qcom\/media-caf\/msm8996|g" {} \;

croot

for hal in audio display media; do
	cd $HOME/omni/hardware/qcom/$hal-caf/msm8996
	find . -name '*.mk' -exec grep -i 'call project' {} \; -print -exec sed -i "s|\$(call project-path-for,qcom-$hal)|hardware\/qcom\/$hal-caf\/msm8996|g" {} \;
done

# finally lunch and exit +_+ let user beeld eet

lunch omni_mido-userdebug
