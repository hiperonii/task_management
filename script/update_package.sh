#!/usr/bin/env bash

cd domain && flutter pub get &&
cd .. &&
cd data && flutter pub get &&
cd .. &&
cd presentation && flutter pub get &&
cd .. &&
flutter pub get
