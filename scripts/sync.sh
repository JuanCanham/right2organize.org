#!/usr/bin/env bash
SITENAME=$1
echo "Sycning files"
aws s3 cp --content-type text/html html/index.html "s3://${SITENAME}/"
aws s3 cp --content-type application/pdf html/Right2Organize.pdf "s3://${SITENAME}/"
for dir in assets bootstrap ; do aws s3 cp --recursive --content-type text/javascript "html/${dir}/" "s3://${SITENAME}/${dir}" ; done
for dir in css bootstrap_theme ; do aws s3 cp --recursive --content-type text/css "html/${dir}/" "s3://${SITENAME}/${dir}" ; done