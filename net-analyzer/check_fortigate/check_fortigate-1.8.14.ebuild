# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Monitoring"
COMMIT="17b0678461b322875c226ec755d7e54a137a74ed"
DESCRIPTION="A nagios plugin for checking Fortigate"
HOMEPAGE="https://github.com/riskersen/Monitoring"
SRC_URI="https://github.com/riskersen/Monitoring/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

DEPEND="dev-perl/List-Compare"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe fortigate/check_fortigate.pl
	insinto /usr/share/snmp/mibs/
	newins fortigate/FortiADC_mibs FORTIADC-MIB.txt

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
