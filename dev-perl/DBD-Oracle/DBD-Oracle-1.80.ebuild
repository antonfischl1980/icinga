# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="MJEVANS"

inherit perl-module

DESCRIPTION="Oracle database driver for the DBI module"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/DBI
	dev-lang/perl
	dev-db/oracle-instantclient"
RDEPEND="$DEPEND"
