# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="MEWP"
DIST_A_EXT="tgz"

inherit perl-module

DESCRIPTION="DBI driver for XBase compatible database files"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-db/freetds[mssql]
	dev-perl/Module-Build
	dev-perl/DBI
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"

src_configure() {
	export SYBASE=/usr
	perl-module_src_configure
}
