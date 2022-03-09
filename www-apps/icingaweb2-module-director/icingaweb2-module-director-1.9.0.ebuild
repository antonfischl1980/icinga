# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga Web 2 plugin for configuration"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-director/"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Icinga/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://codeload.github.com/Icinga/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

# Dependencies according to https://github.com/Icinga/icingaweb2-module-director/blob/master/doc/02-Installation.md
DEPEND=">=net-analyzer/icinga2-2.6.0
	>=www-apps/icingaweb2-2.6.0
	|| (
		dev-lang/php:7.3[curl,iconv,pcntl,posix,sockets,json]
		dev-lang/php:7.4[curl,iconv,pcntl,posix,sockets,json]
		dev-lang/php:8.0[curl,iconv,pcntl,posix,sockets]
		dev-lang/php:8.1[curl,iconv,pcntl,posix,sockets]
	)
	>=www-apps/icingaweb2-module-reactbundle-0.9.0
	>=www-apps/icingaweb2-module-incubator-0.12.0
	>=www-apps/icingaweb2-module-ipl-0.5.0
	"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*

	exeinto /usr/share/icingaweb2/bin/
	doexe "${FILESDIR}/icinga-director.sh"

	doinitd "${FILESDIR}/director"
}
