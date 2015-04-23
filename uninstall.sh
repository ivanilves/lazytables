#!/bin/sh

if [ ${UID} -ne 0 ]; then
  echo "*** Please run under root user or with sudo command!"
  exit 1
fi

INIT_SCRIPT="/etc/init.d/lazytables"
CONF_DIR="/etc/lazytables"

if [ -f ${INIT_SCRIPT} ]; then
  ${INIT_SCRIPT} stop
  update-rc.d -f lazytables remove
  rm ${INIT_SCRIPT}
else
  echo "NB! Init script ${INIT_SCRIPT} not found. Maybe it was already uninstalled?"
fi

test -d ${CONF_DIR} && echo "NB! You need to remove configuration directory ${CONF_DIR} yourself manually..."
