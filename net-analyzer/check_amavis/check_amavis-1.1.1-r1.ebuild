# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Nagios plugin to check amavisd-new daemon"
HOMEPAGE="https://github.com/glensc/monitoring-plugin-check_amavis"
EGIT_REPO_URI="https://github.com/glensc/monitoring-plugin-check_amavis.git"
EGIT_COMMIT="${PV}"
if [ "${PV}" == "1.1.1" ]; then
  EGIT_COMMIT="c202e045c99d9f9b58a9972e2b38419f7da3db16"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
  dev-perl/MIME-tools
"

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}.pl"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins ${FILESDIR}/check_amavis.conf
}

