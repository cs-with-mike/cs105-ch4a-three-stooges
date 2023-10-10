#!/bin/bash
# Authors:
#  - Levi Wicks, lwicks@westmont.edu
#  - David Ponce De Leon, dponcedeleon@westmont.edu
#  - Alexis Leon, alleon@westmont.edu

# Run any commands necessary to set up your language's runtime environment here.
# If the runtime is expected to be present on Ubuntu by default, then do nothing.
echo "Setting up runtime ..."

# I'm checking Python interpreter's version here just as a placeholder.
sudo apt install lua5.4

# Run your Tokki lexer, passing in the first command line argument directly to the lexer.
# Any output to STDOUT should be directed to a text output file titled "out.txt."
echo "Running Tokki ..."

lua tokki.lua $1 > out.txt 
