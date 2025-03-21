#!/bin/sh
(
    set -e
    OWNER=$(gh repo view --json owner --jq '.owner.login'|  tr '[:upper:]' '[:lower:]')
    gh auth token | helm registry login ghcr.io -u "$OWNER" --password-stdin
    helm package charts/vpa-manager --destination ./packaging
    helm push $(ls ./packaging/*.tgz) oci://ghcr.io/$OWNER
    rm -rf ./packaging/*.tgz
)
