#!/bin/bash

HOST_DATADIR=/home/web/demo.qgis.org
BTSYNC_IMAGE=docker-qgis-btsync

docker kill ${BTSYNC_IMAGE}
docker rm ${BTSYNC_IMAGE}

mkdir -p ${DATADIR}
# Uncomment to run with a bash prompt for testing
# You can start apache inside the container using
#
# btsync --config /btsync/btsync.conf --nodaemon

#
#set -x
#docker run --name="${BTSYNC_IMAGE}" \
#	--rm \
#	-p 8888:8888 \
#	-v $DATADIR:$DATADIR \
#	-p 55555:55555 \
#	--entrypoint=/bin/bash \
#	-i -t AIFDR/${BTSYNC_IMAGE} -i

# Once testing is done comment the above and use
# this one rather.
docker run --name="${BTSYNC_IMAGE}" \
	-v $DATADIR:$DATADIR \
	-p 8888:8888 \
	-p 55555:55555 \
	-d -t kartoza/${BTSYNC_IMAGE}


