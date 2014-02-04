#!/bin/bash

for i in *.go; do
	rm -f ${i%.go}.exe
done
