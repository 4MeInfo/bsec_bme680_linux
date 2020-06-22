#!/bin/sh
set  -eu
BSEC_DIR='/tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release'
VERSION='normal_version'
ARCH="${VERSION}/RaspberryPI/PiZero_ArmV6-32bits"
CONFIG='generic_33v_3s_4d'
# Other configs are:
# generic_18v_300s_28d
# generic_18v_300s_4d
# generic_18v_3s_28d
# generic_18v_3s_4d
# generic_33v_300s_28d
# generic_33v_300s_4d
# generic_33v_3s_28d
# generic_33v_3s_4d
CONFIG_DIR='/tmp/bsec_bme680_linux-master/'
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/bsec_interface.h /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_interface.h
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/bsec_datatypes.h /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_datatypes.h
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/libalgobsec.a /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/libalgobsec.a

echo 'Compiling...'
cc -std=c99 -std=gnu99 -std=c11 -std=gnu11 -Wall -Wno-unused-but-set-variable -Wno-unused-variable -static \
  -iquote"${BSEC_DIR}"/API \
  -iquote"${BSEC_DIR}"/algo/bin/${ARCH} \
  -iquote"${BSEC_DIR}"/examples \
  "${BSEC_DIR}"/API/bme680.c \
  "${BSEC_DIR}"/examples/bsec_integration.c \
  ./bsec_bme680.c \
  -L /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/ -lalgobsec \
  -lm -lrt \
  -o bsec_bme680
echo 'Compiled.'

cp "${BSEC_DIR}"/config/"${CONFIG}"/bsec_iaq.config "${CONFIG_DIR}"/
echo 'Copied config.'
