# Copyright (C) 2012 Aljosha Papsch <papsch.al@googlemail.com>
#
# This file is part of librippix.
#
# librippix is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# librippix is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see `http://www.gnu.org/licenses/'.

EXTRA_DIST = rippix-err.c.tpl \
	rippix-err.h.tpl \
	rippix-config.c.tpl \
	rippix-config.h.tpl \
	rippix-lists.def

# Define the headers which are to be installed
LIBRIPPIX_H_INST = rippix.h \
	rippix-err.h \
	rippix-config.h

# Define all other headers
LIBRIPPIX_HEADER = $(LIBRIPPIX_H_INST) \
	cddb.h \
	cddbp.h \
	common.h \
	gettext.h \
	misc-utils.h \
	job-control.h \
	interface-common.h \
	players-manipulation.h \
	ripper-encoder-manipulation.h

# Define the sources
lib_LTLIBRARIES = librippix.la
librippix_la_SOURCES =  rippix-err.c \
	rippix-config.c \
	cddb.c \
	cddbp.c \
	job-control.c \
	misc-utils.c \
	players-manipulation.c \
	ripper-encoder-manipulation.c \
	rippix.c \
	$(LIBRIPPIX_HEADER)

librippix_la_LDFLAGS = $(LIBSOCKET) $(LTLIBTHREAD)
# librippix_la_CFLAGS = $(AUTOOPS_CFLAGS)

# installation target for the headers
headerinstalldir = $(includedir)/librippix
headerinstall_DATA = $(LIBRIPPIX_H_INST)

# Autogenerate sources
rippix-err.c:
	autogen -L $(srcdir) -b rippix-err -o h -Trippix-err.h.tpl $(srcdir)/rippix-lists.def
	autogen -L $(srcdir) -b rippix-err -o c -Trippix-err.c.tpl $(srcdir)/rippix-lists.def && touch $(srcdir)/$@
	cp rippix-err.h $(srcdir)
	cp rippix-err.c $(srcdir)

rippix-config.c:
	autogen -L $(srcdir) -b rippix-config -o h -Trippix-config.h.tpl $(srcdir)/rippix-lists.def
	autogen -L $(srcdir) -b rippix-config -o c -Trippix-config.c.tpl $(srcdir)/rippix-lists.def
	cp rippix-config.h $(srcdir)
	cp rippix-config.c $(srcdir)

# The source files need to be in the source directory when making the tarball.
# If we just put a placeholder in the source directory, the compiler will use
# the placeholder, not the generated file. So we just autogen them and clean-local
# deletes them accordingly.
dist-local: rippix-err.c rippix-config.c

# These are generated sources
clean-local:
	rm -f rippix-err.c rippix-err.h
	rm -f $(srcdir)/rippix-err.c $(srcdir)/rippix-err.h
	rm -f rippix-config.c rippix-config.h
	rm -f $(srcdir)/rippix-config.c $(srcdir)/rippix-config.h
