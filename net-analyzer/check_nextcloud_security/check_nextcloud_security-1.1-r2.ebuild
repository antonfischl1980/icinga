# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="check_nextcloud"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Monitoring plugin to check the status of nextcloud security scan for a given URL"
HOMEPAGE="https://github.com/janvonde/check_nextcloud/"
SRC_URI="https://github.com/janvonde/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="php_targets_php8-2 php_targets_php8-3"
PHP_DEPEND="
	php_targets_php8-2? ( dev-lang/php:8.2 )
	php_targets_php8-3? ( dev-lang/php:8.3 )
"
DEPEND="${PHP_DEPEND}"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	newexe "${MY_PN}.php" "${PN}.php"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
