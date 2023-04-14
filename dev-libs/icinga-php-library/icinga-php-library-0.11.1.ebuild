# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga PHP libraries for Icinga Web 2"
HOMEPAGE="https://github.com/Icinga/icinga-php-library"
MY_GITHUB_AUTHOR="Icinga"
SRC_URI="https://github.com/${MY_GITHUB_AUTHOR}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="php_targets_php7-4 php_targets_php8-0 php_targets_php8-1"
PHP_DEPEND="
	php_targets_php7-4? ( dev-lang/php:7.4 )
	!php_targets_php7-4? ( !dev-lang/php:7.4 )
	php_targets_php8-0? ( dev-lang/php:8.0 )
	!php_targets_php8-0? ( !dev-lang/php:8.0 )
	php_targets_php8-1? ( dev-lang/php:8.1 )
	!php_targets_php8-1? ( !dev-lang/php:8.1 )
"
DEPEND="${PHP_DEPEND}"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto "/usr/share/icinga-php/ipl"
	cd "${S}" || die
	doins -r ./*
}
