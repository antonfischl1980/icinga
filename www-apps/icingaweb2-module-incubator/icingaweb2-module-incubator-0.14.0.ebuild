# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bleeding edge Icinga Web 2 libraries"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-incubator/"
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
	>=www-apps/icingaweb2-2.2.0
	|| (
		dev-lang/php:7.3[curl]
		dev-lang/php:7.4[curl]
		dev-lang/php:8.0[curl]
		dev-lang/php:8.1[curl]
	)"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
