#!/bin/bash
# Exit script instantly if any error is encountered
set -e
function downloadFileFromS3() {
pipenv run aws s3 cp $1 $2
}

LOCAL_RUN_SCRIPT=run_script.sh
downloadFileFromS3 $RUN_SCRIPT $LOCAL_RUN_SCRIPT
chmod a+x $LOCAL_RUN_SCRIPT
./$LOCAL_RUN_SCRIPT
