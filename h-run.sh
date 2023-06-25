#!/usr/bin/env bash

cd `dirname $0`

#export LD_LIBRARY_PATH=.

source colors
source h-manifest.conf
source $CUSTOM_CONFIG_FILENAME

if [[ "$EXTRA" =~ (--gpu-select[ =]+([0-9,]+)) ]]; then
	param="${BASH_REMATCH[1]}"
	GPU_SELECT="${BASH_REMATCH[2]}"
	EXTRA="${EXTRA/$param/}"
fi

[[ -z $GPU_SELECT ]] && GPU_SELECT="${PASS// }"
[[ ! -z $GPU_SELECT ]] && echo "${CYAN}Using CUDA devices: ${BCYAN}$GPU_SELECT${NOCOLOR}" && export CUDA_VISIBLE_DEVICES="$GPU_SELECT"

echo
mkdir -p $CUSTOM_LOG_BASENAME

./aleo-prover -p $HOST -n $WAL  2>&1 | tee --append $CUSTOM_LOG_BASENAME.log