#!/bin/sh -e
#
# setup.sh - configure base-files package
#
# Fink - a package manager that downloads source and installs it
# Copyright (c) 2001 Christoph Pfisterer
# Copyright (c) 2001-2015 The Fink Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA.
#

if [ $# -ne 1 ]; then
  echo "Usage: ./setup.sh <prefix>"
  echo "  Example: ./setup.sh /sw"
  exit 1
fi

basepath=$1

echo "Creating dpkg script wrapper scripts..."
for file in preinst postinst prerm postrm ; do
    sed "s|@PREFIX@|$basepath|g" <$file.in >$file
done

exit 0
