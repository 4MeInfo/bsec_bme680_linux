#!/bin/sh

VERSION='normal_version'

ARCH="${VERSION}/RaspberryPI/PiZero_ArmV6-32bits"

set  -eu

. ./make.config

if [ ! -d "${BSEC_DIR}" ]; then
  echo 'BSEC directory missing.'
  exit 1
fi

if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir "${CONFIG_DIR}"
fi

echo 'Compiling...'
cc -std=c99 -std=gnu99 -std=c11 -std=gnu11 -Wall -Wno-unused-but-set-variable -Wno-unused-variable -static \
  -iquote"${BSEC_DIR}"/API \
  -iquote"${BSEC_DIR}"/algo/bin/${ARCH} \
  -iquote"${BSEC_DIR}"/example \
  "${BSEC_DIR}"/API/bme680.c \
  "${BSEC_DIR}"/example/bsec_integration.c \
  ./bsec_bme680.c \
  -L"${BSEC_DIR}"/algo/${VERSION}/bin/"${ARCH}" -lalgobsec \
  -lm -lrt \
  -o bsec_bme680
echo 'Compiled.'

cp "${BSEC_DIR}"/config/"${CONFIG}"/bsec_iaq.config "${CONFIG_DIR}"/
echo 'Copied config.'

