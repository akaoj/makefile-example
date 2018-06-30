#!/usr/bin/env bash

if ! id -u "$USER_ID" &>/dev/null; then
    groupadd -g "$USER_ID" "$USER_ID"
    useradd -u "$USER_ID" -g "$USER_ID" "$USER_ID"
fi

exec sudo -u "$USER_ID" -- bash -c "$@"
