#!/usr/bin/env bash
set -e
SITENAME=$1
CFN_DIR="$( dirname "${BASH_SOURCE[0]}" )/../cloudformation"
STACKNAME=${SITENAME//./}
DEPLOY_CMD="aws cloudformation deploy --no-fail-on-empty-changeset --tags Classification=Public Site=$SITENAME"

deploy(){
    # shellcheck disable=SC2145
    echo "deploying $1 ($2) [${@:3}]"
    # shellcheck disable=SC2068
    $DEPLOY_CMD --stack-name "$1" --template-file "${CFN_DIR}/$2" --parameter-overrides ${@:3}
    aws cloudformation wait stack-exists --stack-name "$1"
}

get_output(){
    echo "apt i" | jq -r ".[]|select(.OutputKey==\"$2\").OutputValue"
}

AWS_DEFAULT_REGION=us-east-1 deploy "${STACKNAME}-certificate" certificate.yaml SiteName="$SITENAME"
OUTPUTS=$(aws cloudformation describe-stacks --region us-east-1 --stack-name "${STACKNAME}-certificate" --query Stacks[0].Outputs)

AWS_DEFAULT_REGION=us-west-1 deploy "$STACKNAME" site.yaml SiteName="$SITENAME" CertificateARN="$(get_output "$OUTPUTS" CertificateARN)" WWWCertificateARN="$(get_output "$OUTPUTS" WWWCertificateARN)"


