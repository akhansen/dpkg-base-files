#!/bin/sh -e
#
# install.sh - install base-files package
#
# Fink - a package manager that downloads source and installs it
# Copyright (c) 2001 Christoph Pfisterer
# Copyright (c) 2001-2009 The Fink Team
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
  echo "Usage: ./install.sh <prefix>"
  echo "  Example: ./install.sh /tmp/builddirectory/sw"
  echo "WARNING: Don't call install.sh directly, use inject.pl instead."
  echo "         You have been warned."
  exit 1
fi

basepath=$1


echo "Creating directories..."

mkdir -p $basepath
chmod 755 $basepath

for dir in etc etc/profile.d bin sbin lib include \
	   share share/info share/man share/doc \
	   share/base-files lib/fink lib/fink/dpkg-wrappers \
	   lib/perl5 lib/perl5/darwin lib/perl5/auto lib/perl5/darwin/auto \
	   var var/run var/spool var/log src \
	   share/doc/base-files ; do
  mkdir $basepath/$dir
  chmod 755 $basepath/$dir
done


echo "Copying files..."

install -c -p -m 644 init.sh $basepath/bin/
install -c -p -m 644 init.csh $basepath/bin/
# generate a dummy file to avoid problems with zsh
touch $basepath/etc/profile.d/dummy.sh
chmod 644 $basepath/etc/profile.d/dummy.sh

install -c -p -m 755 pager $basepath/bin/
install -c -p -m 755 editor $basepath/bin/

install -c -p -m 644 dir-base $basepath/share/base-files/
install -c -p -m 644 COPYING $basepath/share/doc/base-files/

for wrapper in preinst postinst prerm postrm ; do
  install -c -p -m 755 $wrapper $basepath/lib/fink/dpkg-wrappers/
done


echo "Done."
exit 0