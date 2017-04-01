#!/bin/sh
swift build --clean
swift build -c release
cp .build/release/WheatFlower /usr/local/bin/wheatflower
