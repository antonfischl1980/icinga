# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="Nagios/Icinga plugin for checking status of PostgreSQL databases"
HOMEPAGE="http://bucardo.org/wiki/Check_postgres"
SRC_URI="https://github.com/bucardo/check_postgres/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile(){
	perl-module_src_compile
}

src_install(){
	exeinto /usr/lib64/nagios/plugins/
	doexe blib/script/check_postgres.pl

	dodoc check_postgres.pl.html README* TODO
	doman blib/man1/check_postgres.1p

}
