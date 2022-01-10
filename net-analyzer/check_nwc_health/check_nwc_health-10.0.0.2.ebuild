# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#nagios-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="plugin which checks the health of network components and interfaces."
HOMEPAGE="https://labs.consol.de/nagios/check_nwc_health/"
SRC_URI="https://labs.consol.de/assets/downloads/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-perl/JSON
	dev-perl/File-Slurp
	dev-perl/GLPlugin
	"
BDEPEND=""

src_configure(){
	# Should match net-analyzer/{monitoring,nagios}-plugins.
	econf --libexecdir="/usr/$(get_libdir)/nagios/plugins/contrib" --disable-standalone
}

src_install(){
	default

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	newins "${FILESDIR}/nwc_health.template" "nwc_health.ini"
}
