# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="Graphite-web, without the interface. Just the rendering HTTP API."
HOMEPAGE="https://github.com/brutasse/graphite-api https://pypi.org/project/graphite-api/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/01-timezone.patch"
)

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86 amd64-linux x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/cairocffi[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-1.5.7[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/structlog[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	www-servers/gunicorn
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}

python_install_all() {
	newconfd "${FILESDIR}/conf.d-graphite-api" "${PN}"
	newinitd "${FILESDIR}/init.d-graphite-api" "${PN}"

	insinto "/etc/"
	doins "${FILESDIR}/graphite-api.yaml"

	keepdir /var/lib/graphite-api/
	fowners nobody:nobody /var/lib/graphite-api/
}
