# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Create top-level views of your applications in a graphical editor."
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-businessprocess/"
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

DEPEND="
	>=www-apps/icingaweb2-2.9.0
	|| (
		dev-lang/php:7.3[curl]
		dev-lang/php:7.4[curl]
		dev-lang/php:8.0[curl]
		dev-lang/php:8.1[curl]
	)
	>=dev-libs/icinga-php-library-0.8.0
	>=dev-libs/icinga-php-thirdparty-0.11.0_rc1
	"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
