#!/bin/sh

set  -eu

. ./make.config

if [ ! -d "${BSEC_DIR}" ]; then
  echo 'BSEC directory missing.'
  exit 1
fi

if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir "${CONFIG_DIR}"
fi

#cp ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/avr/AVR8_megaAVR/bsec_datatypes.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_datatypes.h
#cp ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/avr/AVR8_megaAVR/bsec_interface.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_interface.h
#cp ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/avr/AVR8_megaAVR/libalgobsec.a ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/libalgobsec.a
#cp ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/inc/bsec_datatypes.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_datatypes.h
#cp ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/inc/bsec_interface.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_interface.h
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/bsec_interface.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_interface.h
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/bsec_datatypes.h ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/bsec_datatypes.h
cp /tmp/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/algo/normal_version/bin/RaspberryPI/PiZero_ArmV6-32bits/libalgobsec.a ~/Downloads/bsec_bme680_linux-master/.src/BSEC_1.4.7.4_Generic_Release/examples/libalgobsec.a

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

