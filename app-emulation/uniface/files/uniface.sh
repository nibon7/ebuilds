#!/bin/sh
UNIFACE_HOME_DIR=/usr/lib/ksvd_client
export LD_LIBRARY_PATH=${UNIFACE_HOME_DIR}/lib
${UNIFACE_HOME_DIR}/bin/uniface $@
