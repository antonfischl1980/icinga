# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="easy build thruk perl dependencies"
HOMEPAGE="https://github.com/sni/thruk_libs"
SRC_URI="https://github.com/sni/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="
	dev-db/mysql-connector-c
	media-libs/gd
"

BDEPEND="
	${DEPEND}
	app-admin/chrpath
"
