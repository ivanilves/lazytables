#!/bin/bash
WORKING_PATH=$(dirname $0)

if [ ${UID} -ne 0 ]; then
  echo "*** Please run under root user or with sudo command!"
  exit 1
fi

INIT_SCRIPT="/etc/init.d/lazytables"
CONF_DIR="/etc/lazytables"
CONF_FILE="${CONF_DIR}/lazytables.conf"
RULES_DIR="${CONF_DIR}/rules.d"

test -f ${INIT_SCRIPT} && INIT_SCRIPT_EXISTS=1
install "${WORKING_PATH}"${INIT_SCRIPT} ${INIT_SCRIPT}

test -d ${CONF_DIR}  || install -d     "${WORKING_PATH}"${CONF_DIR}   ${CONF_DIR}
test -f ${CONF_FILE} || install -m644  "${WORKING_PATH}"${CONF_FILE}  ${CONF_FILE}

if [ ! -d ${RULES_DIR} ]; then
  install -d    "${WORKING_PATH}"${RULES_DIR}   ${RULES_DIR}
  install -m644 "${WORKING_PATH}"${RULES_DIR}/* ${RULES_DIR}/
fi

test ${INIT_SCRIPT_EXISTS} || update-rc.d lazytables start 20 2 3 4 5 . stop 80 0 1 6 .
