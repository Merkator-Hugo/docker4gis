#!/bin/bash

dir="${1:-.}"

find "$dir" -name "test.sh" -exec {} \;

if find "$dir" -name "*.bats" >/dev/null 2>&1; then
    if ! command -v bats; then
        bats_url=https://github.com/bats-core/bats-core
        echo "WARN - Cannot test without [bats]($bats_url); continuing without running any tests now."
        echo "Consider npm install -g bats"
        exit
    fi
    "$DOCKER_BASE"/plugins/bats/install.sh
    time bats -r "$dir"
fi
