# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="KEMP LoadMaster Nagios Monitoring Plugin"
HOMEPAGE="https://www.thomas-dohl.de/?Projekte___Nagios%2FIcinga___Plugin_Loadmaster"
SRC_URI="https://www.thomas-dohl.de/downloads/nagios_icinga/check_loadmaster.pl"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_unpack() {
	mkdir "${P}"
	cp "${DISTDIR}/${A}" "${P}/${PN}.pl"
}

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}.pl"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
