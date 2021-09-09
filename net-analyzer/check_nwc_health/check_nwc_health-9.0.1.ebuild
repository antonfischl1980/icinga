# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN#nagios-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="check_nwc_health is a plugin which checks the health of network components and interfaces."
HOMEPAGE="https://labs.consol.de/nagios/${MY_PN}/"
SRC_URI="https://labs.consol.de/assets/downloads/nagios/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
  "${FILESDIR}"/01_snmp_timeout.patch
)

S="${WORKDIR}/${MY_P}"

src_configure(){
	# Should match net-analyzer/{monitoring,nagios}-plugins.
	econf --libexecdir="/usr/$(get_libdir)/nagios/plugins/contrib"
}

src_install(){
	default

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	newins "${FILESDIR}/nwc_health.template" "nwc_health.ini"
}

