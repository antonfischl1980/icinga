# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga PHP libraries for Icinga Web 2"
HOMEPAGE="https://github.com/Icinga/icinga-php-thirdparty"
# temporary measure until upstream releases 0.11.0
SRC_URI="https://nextcloud.fischl-online.de/s/RB4pePgBL9YCtZB/download/icinga-php-thirdparty-0.11.0_rc1.tar.gz"
S="${WORKDIR}/icinga-php-thirdparty-snapshot-nightly"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-lang/php:*"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto "/usr/share/icinga-php/vendor"
	cd "${S}" || die
	doins -r ./*
}
