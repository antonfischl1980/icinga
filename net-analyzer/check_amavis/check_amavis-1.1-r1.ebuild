# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nagios plugin to check amavisd-new daemon"
HOMEPAGE="https://github.com/glensc/monitoring-plugin-check_amavis"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/glensc/monitoring-plugin-check_amavis.git"
else
	MY_PN="monitoring-plugin-check_amavis"
	MY_P="$MY_PN-$PV"
	SRC_URI="https://github.com/glensc/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

if [ "${PVR}" == "1.1-r1" ]; then
	PATCHES="$FILESDIR/bugfixes-2017-01-14.patch"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools"

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}.pl"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/check_amavis.conf"
}
