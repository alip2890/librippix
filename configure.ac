#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

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

AC_PREREQ([2.69])
AC_INIT([librippix], [0.1], [papsch.al@googlemail.com], [librippix], [http://localhost])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([-Wall -Werror])
AM_SILENT_RULES([yes])
AM_MAINTAINER_MODE([enable])

# Checks for programs.
AC_USE_SYSTEM_EXTENSIONS
AC_PROG_CC_C99
AC_PROG_LIBTOOL
gl_EARLY
gl_INIT

# All necessary checks are done by gnulib, so nothing needs to be done here.
# Checks for libraries.
# Checks for header files.
# Checks for typedefs, structures, and compiler characteristics.
# Checks for library functions.

AC_OUTPUT([Makefile librippix.pc lib/Makefile librippix/Makefile])
