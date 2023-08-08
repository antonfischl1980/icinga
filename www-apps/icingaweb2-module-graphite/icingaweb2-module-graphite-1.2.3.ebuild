# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Module for displaying Graphite data directly in Icinga Web 2"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-graphite/"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Icinga/${PN}.git"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://codeload.github.com/Icinga/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="php_targets_php7-4 php_targets_php8-0 php_targets_php8-1 php_targets_php8-2"
PHP_DEPEND="
	php_targets_php7-4? ( dev-lang/php:7.4[curl] )
	php_targets_php8-0? ( dev-lang/php:8.0[curl] )
	php_targets_php8-1? ( dev-lang/php:8.1[curl] )
	php_targets_php8-2? ( dev-lang/php:8.2[curl] )
"
RDEPEND="
	${PHP_DEPEND}
	>=dev-libs/icinga-php-library-0.9.0
	>=dev-libs/icinga-php-thirdparty-0.10.0
	>=www-apps/icingaweb2-2.9.0
	!!dev-python/graphite-api
	"
DEPEND=""

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
