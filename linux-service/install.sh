#!/bin/bash
#
# MIT License
#
# Copyright (c) 2023 Gerald Venzl
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

# Exit on errors
# Great explanation on https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeo pipefail

# Ensure #$ORACLE_HOME is set
if [ -z "${ORACLE_HOME}" ]; then
  echo "Error: \$ORACLE_HOME needs to be set. Please set \$ORACLE_HOME and rerun the installation."
  exit 1;
fi;

# Ensure #$ORACLE_SID is set
if [ -z "${ORACLE_SID}" ]; then
  echo "Error: \$ORACLE_SID needs to be set. Please set \$ORACLE_SID and rerun the installation."
  exit 1;
fi;

echo "Enabling Oracle Database for startup in '/etc/oratab'..."
sudo sed -i -e "\$s|${ORACLE_SID}:${ORACLE_HOME}:N|${ORACLE_SID}:${ORACLE_HOME}:Y|" /etc/oratab

echo "Installing Oracle Database service..."
sudo cp oracle-database.service /etc/systemd/system/
sudo sed -i -e "s|###ORACLE_HOME###|$ORACLE_HOME|g" /etc/systemd/system/oracle-database.service

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Enabling oracle database service..."
sudo systemctl enable oracle-database

echo "Starting oracle database service..."
sudo systemctl start oracle-database

echo "Congratulations, the Oracle Database service has now been installed!"
echo "You can now start and stop Oracle Database via 'systemclt start|stop oracle-database'."
