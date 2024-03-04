#!/usr/bin/env bash
set -euo pipefail

FEDORA_MAJOR_VERSION=$(rpm -E %fedora)
REPO_FILE_PATH=/etc/yum.repos.d/_copr_ycollet-audinux.repo
  
wget "https://copr.fedorainfracloud.org/coprs/ycollet/audinux/repo/fedora-${FEDORA_MAJOR_VERSION}/ycollet-audinux-fedora-${FEDORA_MAJOR_VERSION}.repo" \
 -O $REPO_FILE_PATH

rpm-ostree cliwrap install-to-root /
rpm-ostree override replace \
    --experimental \
    --remove=kernel \
    --remove=kernel-core \
    --from repo=copr:copr.fedorainfracloud.org:ycollet:audinux \
    kernel-rt-mao

rm -f $REPO_FILE_PATH
