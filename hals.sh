#!/bin/bash

for hal in display media audio; do
        rm -rf hardware/qcom/$hal-caf/msm8996
done
for hal in display media audio; do
        git clone https://github.com/ArrowOS/android_hardware_qcom_$hal -b arrow-9.x-caf-8996 hardware/qcom/$hal-caf/msm8996
done
