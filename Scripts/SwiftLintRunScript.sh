#!/bin/bash

echo "Running SwiftLint..."

# Path to the SwiftLint configuration file
SWIFTLINT_CONFIG="${PROJECT_DIR}/.swiftlint.yml"
echo "Using SwiftLint config: ${SWIFTLINT_CONFIG}"

# Run SwiftLint with the specified config
swiftlint --config "${SWIFTLINT_CONFIG}" --strict

if [[ "$(uname -m)" == arm64 ]]
then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if command -v swiftlint >/dev/null 2>&1
then
echo "Config file path: ${PROJECT_DIR}/.swiftlint.yml"
#  swiftlint --config "${PROJECT_DIR}/.swiftlint.yml" --strict
swiftlint --config "${SWIFTLINT_CONFIG}" --strict
else
    echo "warning: `swiftlint` command not found - See https://github.com/realm/SwiftLint#installation for installation instructions."
fi

