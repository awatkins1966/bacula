#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END

#
# Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
#
BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk



COMPONENT_NAME=         bacula
COMPONENT_VERSION=      9.6.2
COMPONENT_SRC=          $(COMPONENT_NAME)-$(COMPONENT_VERSION)
IPS_COMPONENT_VERSION=  $(COMPONENT_VERSION)
BUILD_VERSION=          1

COMPONENT_PROJECT_URL=  https://www.bacula.org/
#COMPONENT_BUGDB=       Advanced Backup System with Bacula
#COMPONENT_ANITYA_ID=    1865

TPNO = 10000

COMPONENT_ARCHIVE=      bacula-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= 
COMPONENT_ARCHIVE_URL=  https://sourceforge.net/projects/$(COMPONENT_NAME)/files/$(COMPONENT_NAME)/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)/download
COMPONENT_MAKE_JOBS=    1

BUILD_STYLE=    configure

# configure does not accept many of the options set in
# configure.mk (CC=, CXX=, --bindir, --libdir, --sbindir).
#CONFIGURE_DEFAULT_DIRS set to NO since we need "--libdir=/usr/lib/amd64" set otherwise it could have been YES
CONFIGURE_DEFAULT_DIRS= no
CONFIGURE_PREFIX =      $(USRDIR)/$(COMPONENT_NAME)
CONFIGURE_OPTIONS += PATH="$(PATH):/usr/mysql/5.7/bin"
#CONFIGURE_OPTIONS += --prefix=/usr/bacula
CONFIGURE_OPTIONS += --mandir=$(CONFIGURE_PREFIX)/man 
CONFIGURE_OPTIONS += --bindir=$(CONFIGURE_PREFIX)/bin
CONFIGURE_OPTIONS += --libdir=$(CONFIGURE_PREFIX)/lib/$(MACH64)

CONFIGURE_OPTIONS += --datarootdir=$(CONFIGURE_PREFIX)
#
# Need to add all config options by hand
CONFIGURE_OPTIONS += --with-working-dir=/var/bacula/working
CONFIGURE_OPTIONS += --with-pid-dir=/var/run
CONFIGURE_OPTIONS += --with-logdir=/var/bacula/log
CONFIGURE_OPTIONS += --with-archivedir=/var/bacula/backup
CONFIGURE_OPTIONS += --with-scriptdir=$(CONFIGURE_PREFIX)/scripts
CONFIGURE_OPTIONS += --with-plugindir=$(CONFIGURE_PREFIX)/plugins
CONFIGURE_OPTIONS += --enable-smartalloc
CONFIGURE_OPTIONS += --enable-conio
CONFIGURE_OPTIONS += --docdir=$(CONFIGURE_PREFIX)/doc 
CONFIGURE_OPTIONS += --enable-largefile 
CONFIGURE_OPTIONS += --with-mysql
CONFIGURE_OPTIONS += --with-dump-email=backup@dcs.bbk.ac.uk 
CONFIGURE_OPTIONS += --with-job-email=backup@dcs.bbk.ac.uk 
CONFIGURE_OPTIONS += --with-smtp-host=smtp.dcs.bbk.ac.uk 
CONFIGURE_OPTIONS += --with-db-name=baculadb 
CONFIGURE_OPTIONS += --with-db-user=bacula 
CONFIGURE_OPTIONS += --with-db-password=Backup8756765 
CONFIGURE_OPTIONS += --with-baseport=9101 
#
# configure
COMPONENT_PRE_CONFIGURE_ACTION = \
	$(CLONEY) $(SOURCE_DIR) $(@D);

#COMPONENT_POST_CONFIGURE_ACTION = \
#	(cd $(SOURCE_DIR)/src; cp config.h  $(BUILD_DIR_64))

##COMPONENT_POST_BUILD_ACTION= \
##	(cd $(PROTO_DIR) ; $(MKDIR) -p var/spool/MIMEDefang var/clamav)
#
TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk
#
#CFLAGS += "-g -O2 -Wall -m64"
#CONFIGURE_ENV += CFLAGS="-g -O2 -Wall -m64"
#CONFIGURE_ENV += "-m64"
# remove warnings that packages are missing 
IPS_PKG_NAME=         storage/bacula
#REQUIRED_PACKAGES += developer/build/autoconf
REQUIRED_PACKAGES += library/security/openssl
#REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
#REQUIRED_PACKAGES += library/json-c 
#REQUIRED_PACKAGES += web/curl
#REQUIRED_PACKAGES += library/ncurses
#REQUIRED_PACKAGES += library/libmilter
#REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += database/mysql-57/library
REQUIRED_PACKAGES += library/ncurses
#depend type=require fmri=pkg:/database/mysql-57/library@5.7.29-11.4.21.0.1.69.0
#depend type=require fmri=pkg:/library/ncurses@6.1.0.20190105-11.4.21.0.1.69.0
#depend type=require fmri=pkg:/library/security/openssl@1.0.2.21-11.4.21.0.1.69.0
#depend type=require fmri=pkg:/library/zlib@1.2.11-11.4.21.0.1.69.0
