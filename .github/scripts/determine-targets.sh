#!/bin/bash

set -e

# Determine base commit.
echo "GITHUB_BASE_REF=${GITHUB_BASE_REF}"
echo "GITHUB_HEAD_REF=${GITHUB_HEAD_REF}"
OLD_COMMIT=$(git merge-base remotes/origin/${GITHUB_HEAD_REF} remotes/origin/${GITHUB_BASE_REF})

# Determine targets.
echo "OLD_COMMIT=${OLD_COMMIT}"
echo "NEW_COMMIT=${NEW_COMMIT}"
TARGETS="$(pixlet community target-determinator --old ${OLD_COMMIT} --new ${NEW_COMMIT})"

# Convert new lines to spaces. Maybe Pixlet should do this?
TARGETS="$(echo "${TARGETS}" | tr "\n" " ")"
echo "${TARGETS}"

# Record output to GitHub variable.
echo "targets=${TARGETS}" >> ${GITHUB_OUTPUT}