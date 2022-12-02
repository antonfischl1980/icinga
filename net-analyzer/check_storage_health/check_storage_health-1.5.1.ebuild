# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#nagios-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="nagios plugin for checking storage systems like HP Lefthand, Netapp"
HOMEPAGE="https://labs.consol.de/nagios/check_storage_health/"
SRC_URI="https://labs.consol.de/assets/downloads/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/GLPlugin"
BDEPEND=""

src_configure(){
	# Should match net-analyzer/{monitoring,nagios}-plugins.
	econf --libexecdir="/usr/$(get_libdir)/nagios/plugins/contrib" --disable-standalone
}

src_install(){
	default

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
