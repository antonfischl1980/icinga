# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

DESCRIPTION="Structured Logging for Python"
HOMEPAGE="https://github.com/hynek/structlog/ https://pypi.org/project/structlog/ https://www.structlog.org/en/stable/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND=""
BDEPEND="
		dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/flit_core-3.4[${PYTHON_USEDEP}]
		<dev-python/flit_core-4[${PYTHON_USEDEP}]
		test? (
				dev-python/nose[${PYTHON_USEDEP}]
				>=dev-python/pytest-6[${PYTHON_USEDEP}]
				dev-python/pytest-asyncio[${PYTHON_USEDEP}]
				>=dev-python/freezegun-0.2.8[${PYTHON_USEDEP}]
				dev-python/simplejson[${PYTHON_USEDEP}]
		)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
