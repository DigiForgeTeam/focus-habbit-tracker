#!/bin/bash

if which swiftlint >/dev/null; then
    echo "Running SwiftLint..."
    swiftlint lint --strict
else
    echo "Warning: SwiftLint is not installed. Please install it from https://github.com/realm/SwiftLint"
fi

#if which swiftlint >/dev/null; then
#    swiftlint lint --config ${PROJECT_DIR}/.swiftlint.yml --strict
#else
#    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
#fi
