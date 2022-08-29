function _sys_notify() {
    local notification_command="display notification \"$2\" with title \"$1\""
    osascript -e "$notification_command"
}
alias sys-notify="_sys_notify $1 $2"

function gr {
    ## If the current working directory is inside of a git repository,
    ## this function will change it to the git root (ie, the directory
    ## that contains the .git/ directory), and then print the new directory.
    git branch > /dev/null 2>&1 || return 1

    cd "$(git rev-parse --show-cdup)".
    pwd
}

function find_time_machine_exclusions {
    mdfind "com_apple_backup_excludeItem = com.apple.backupd"
}

# Switch current Java version
# I do not know if this is compatible with asdf
function jdk() {
    if (( $# == 0 )); then
        # If no version given, then list available Java versions
        echo "Available Java versions:"
        /usr/libexec/java_home -V
    else
        echo "Switching to Java ${1}"
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v "$version");
        java -version
    fi
}

## AWS Functions ##
function s3-bucket-size {
    aws cloudwatch get-metric-statistics --profile foursquare --namespace AWS/S3 --metric-name BucketSizeBytes --start-time $(date --date="yesterday" +%Y-%m-%d) --end-time $(date +%Y-%m-%d) --period 86400 --statistics Maximum --dimensions Name=BucketName,Value=4sq-partner-pinpoint-liveramp Name=StorageType,Value=StandardStorage --query 'Datapoints[0].Maximum'
}

function s3-path-size {
    aws s3 ls --summarize --human-readable --recursive "$1" | tail -2
}

function scp-dev {
    path_relative_to_home="${PWD#"$HOME"/}"
    echo "path_relative_to_home: $path_relative_to_home"
    scp "$1" dev-jonshea:"~/$path_relative_to_home/$1"
}

function scp-web {
    path_relative_to_home="${PWD#"$HOME"/}"
    echo "path_relative_to_home: $path_relative_to_home"
    scp "$1" dev-jonshea:"~/foursquare/web/$1"
}