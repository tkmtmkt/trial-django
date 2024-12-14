#!/usr/bin/env bash
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

LANG=ja_JP.UTF-8

pushd /assets
pip install --upgrade pip pipenv
pipenv install --system
popd

# Remove installation files
rm -r /assets/

exit $?
