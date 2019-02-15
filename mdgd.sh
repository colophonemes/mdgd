#!/bin/bash
set -o errexit -o pipefail

cp_open() {
  if hash open 2>/dev/null; then
      open "$@"
  elif hash xdg-open 2>/dev/null; then
      xdg-open "$@"
  else
      gnome-open "$@"
  fi
}

# check we've actually set args, if not print help
if [ $# -eq 0 ]; then
  echo 'Usage:

  From file:  mdgd /path/to/file.htm filename
  From STDIN: mdgd - filename
'
  exit 0
fi

filename=$2

# get input file from STDIN or filename
data=$(
  file=${1--}
  while IFS= read -r line; do
    printf '%s\n' "$line"
  done < <(cat -- "$file")
)

# parse markdown with markdown-it
md=$(echo $data | markdown-it)
# upload the file with gdrive
upload=$(echo $md | gdrive upload - --mime application/vnd.google-apps.document "$filename")
# get the fileID from the upload result
fileid=$(echo "$upload" | grep Uploaded | sed 's/Uploaded \([^ ]*\).*/\1/')
# use gdrive to get the file info
fileinfo=$(gdrive info $fileid)
# get the ViewUrl returned by gdrive info
fileurl=$(echo "$fileinfo" | grep ViewUrl | sed 's/ViewUrl: \(.*\)$/\1/')
#open the URL in a browser
cp_open "$fileurl"
