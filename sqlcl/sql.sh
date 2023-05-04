# MIT License
#
# Copyright (c) 2023 Kris Rice, Gerald Venzl
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

sql() {
  # Remote source this script
  #
  # . <(curl -s https://github.com/gvenzl/oracle-tools/blob/main/sqlcl.sh)

  # Set the stage directory
  STAGE_DIR=/var/tmp

  # Check whether internet connection exists
  if ping -c 1 -W 3 download.oracle.com > /dev/null; then

    # Get current ETAG from download
    ETAG=$(curl -I -s https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip | tr -d '\r'  | sed -En 's/^ETag: (.*)/\1/p')

    echo "REMOTE-ETAG: $ETAG"

    # Compare to last ETag saved
    if [[ -e $STAGE_DIR/sqlcl.etag ]]; then
        CURRENT_ETAG=$(cat $STAGE_DIR/sqlcl.etag)
        echo "LOCAL-ETAG: $CURRENT_ETAG"
    else
        CURRENT_ETAG="none"
    fi

    # Check if ETags match
    if [[ "$ETAG" != "$CURRENT_ETAG" ]]; then
      echo "Downloading..."
      curl -sS -o $STAGE_DIR/sqlcl-latest.zip \
            --header 'If-None-Match: "${CURRENT_ETAG}"' \
            https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip
      echo Unzip....
      echo "$ETAG" > $STAGE_DIR/sqlcl.etag
      echo "Removing old SQLcl"
      rm -rf $STAGE_DIR/sqlcl
      echo Unzipping to $STAGE_DIR/sqlcl
      unzip   -qq -d $STAGE_DIR $STAGE_DIR/sqlcl-latest.zip
    else
      echo "SQLcl is current"
    fi
   else
     echo "Internet connection to download.oracle.com not available."
     if [[ ! -f $STAGE_DIR/sqlcl/bin/sql ]]; then
       echo "SQLcl cannot be downloaded, please check internet connection."
       return 1;
     else
       echo "Cannot verify latest SQLcl version."
     fi
   fi

   # Run SQLcl
   $STAGE_DIR/sqlcl/bin/sql "$*"
}
