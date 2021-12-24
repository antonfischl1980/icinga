# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#nagios-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="plugin which checks the health of network components and interfaces."
HOMEPAGE="https://labs.consol.de/nagios/check_mailbox_health/"
SRC_URI="https://labs.consol.de/assets/downloads/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-perl/Date-Manip
	dev-perl/Email-MIME
	dev-perl/GLPlugin
	dev-perl/List-MoreUtils
	dev-perl/Net-IMAP-Simple
	"
BDEPEND=""

src_configure(){
	# Should match net-analyzer/{monitoring,nagios}-plugins.
	econf --libexecdir="/usr/$(get_libdir)/nagios/plugins/contrib" --disable-standalone
}

src_install(){
	default

	insinto /usr/share/icinga2/include/plugins-contrib.d
	doins "${FILESDIR}/check_mailbox_health.conf"

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	doins "${FILESDIR}/check_mailbox_health.ini"
}
