# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7..10} )
inherit distutils-r1

DESCRIPTION="Apache / Config::General configuration file parser "
HOMEPAGE="https://github.com/etingof/apacheconfig"
SRC_URI="https://github.com/etingof/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="
	dev-python/ply
	dev-python/six
"

distutils_enable_tests pytest
