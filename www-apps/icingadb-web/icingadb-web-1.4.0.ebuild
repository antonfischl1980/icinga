# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="UI for Icinga DB"
HOMEPAGE="https://icinga.com/docs/icinga-db-web/"
SRC_URI="https://github.com/Icinga/icingadb-web/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="php_targets_php8-2 php_targets_php8-3 php_targets_php8-4 php_targets_php8-5"

PHP_DEPEND="
	php_targets_php8-2? ( dev-lang/php:8.2[curl,xml])
	php_targets_php8-3? ( dev-lang/php:8.3[curl,xml])
	php_targets_php8-4? ( dev-lang/php:8.4[curl,xml])
	php_targets_php8-5? ( dev-lang/php:8.5[curl,xml])
"
RDEPEND="
	>=dev-libs/icinga-php-library-0.20.0
	>=dev-libs/icinga-php-thirdparty-0.15.0
	>=www-apps/icingaweb2-2.9.0
	${PHP_DEPEND}
"

src_install() {
	insinto "/usr/share/icingaweb2/modules/icingadb/"
	doins -r "${S}"/*
}
