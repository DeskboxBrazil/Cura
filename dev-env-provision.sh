#!/usr/bin/sh -e
virtualenv --python=python3 --system-site-packages .python
.python/bin/pip install 'google-apputils' 'protobuf>=3.0.0a3'
