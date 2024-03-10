#!/usr/bin/env bash
set -e
SITENAME=$1
STACKNAME=${SITENAME//./}

# shellcheck disable=SC2016
DISTRIBUTION=$(aws cloudformation describe-stacks --stack-name "$STACKNAME" --query 'Stacks[0].Outputs[?OutputKey==`CloudfrontDistribution`].OutputValue' --output text)
INVALIDATION=$(aws cloudfront create-invalidation --paths '/*' --distribution-id "$DISTRIBUTION" --query Invalidation.Id --output text)
aws cloudfront wait invalidation-completed --distribution-id "$DISTRIBUTION" --id "$INVALIDATION"
