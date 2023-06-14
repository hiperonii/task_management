#!/usr/bin/env bash

cd data &&
flutter packages pub run build_runner build -d &&
cd ..