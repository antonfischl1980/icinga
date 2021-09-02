# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN#nagios-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A nagios plugin for checking USV health"
HOMEPAGE="https://labs.consol.de/nagios/${MY_PN}/"
SRC_URI="https://labs.consol.de/assets/downloads/nagios/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_configure(){
	# Should match net-analyzer/{monitoring,nagios}-plugins.
	econf --libexecdir="/usr/$(get_libdir)/nagios/plugins/contrib"
}

src_install(){
	default

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins ${FILESDIR}/${PN}.conf
}
# Here we should have a pkg_preinst() that creates the nagios user/group
# (using the same command from e.g. net-analyzer/nagios-plugins). But
# right now, the build system for check_mysql_health has a bug: it
# doesn't use the configured user (INSTALL_OPTIONS aren't passed to
# /usr/bin/install), so it's pointless. Don't forget to inherit
# user.eclass!
