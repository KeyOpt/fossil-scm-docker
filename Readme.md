# Simple Container image for building fossil-scm

Configured to build the latest trunk version of fossil-scm by default, but you can specify a version with `make build VERSION=2.15.1` for instance.  Configured Makefile using buildx to build linux/amd64, linux/arm64, linux/386, linux/arm/v7, and linux/arm/v6.

# Workflow
This repository is maintained in a local fossil repo which is then pushed to github using [fossil git export](https://fossil-scm.org/home/doc/trunk/www/mirrortogithub.md).

Let me know if you see any room to improve it!
