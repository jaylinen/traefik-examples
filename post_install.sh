#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# This script is run by the npm postinstall hook and is used for installing
# the reveal.js dependencies
cd modules/assets/revealjs && npm install
