# Copyright 1999-2022 Gentoo Authors
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

DEPEND=">=net-analyzer/icinga2-2.4.3
	>=www-apps/icingaweb2-2.9.0
	>=dev-libs/icinga-php-library-0.8.0
	>=dev-libs/icinga-php-thirdparty-0.10.0
	|| (
		dev-lang/php:7.4[curl]
		dev-lang/php:8.0[curl]
		dev-lang/php:8.1[curl]
	)
	!!dev-python/graphite-api
	"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
