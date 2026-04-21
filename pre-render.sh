#!/bin/sh
# Copies extension resources into example/ so xelatex can find them when
# rendering documents from that subdirectory.
mkdir -p example/_extensions/rogle-lab
cp -r _extensions/rogle-lab/resources example/_extensions/rogle-lab/
