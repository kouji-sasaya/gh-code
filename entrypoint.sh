#!/bin/bash
set -e

# Start SSH daemon
sudo service ssh start

cd /workdir
if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash -i
fi