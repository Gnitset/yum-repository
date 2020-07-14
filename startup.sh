#!/bin/bash

mkdir -p /data
cd /data

export KEYID=$(</gpg/fingerprint)

gpg --import /gpg/gpg.key /gpg/gpg.pub
cp /gpg/gpg.pub /data/RPM-GPG-KEY-${KEYID}

echo "%_signature gpg" > ~/.rpmmacros
echo "%_gpg_name ${KEYID}" >> ~/.rpmmacros

rpm --resign *.rpm

createrepo .

gpg --default-key ${KEYID} --detach-sign --armor repodata/repomd.xml

exec /usr/sbin/nginx -g 'daemon off;'
