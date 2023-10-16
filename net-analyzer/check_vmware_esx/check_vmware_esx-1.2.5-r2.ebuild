# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="check_vmware_esx for VMware Monitoring"
HOMEPAGE="https://github.com/BaldMansMojo/check_vmware_esx"
SRC_URI="https://github.com/BaldMansMojo/${PN}/archive/refs/tags/v.${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-v.${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

PATCHES=( "${FILESDIR}"/"${PN}-1.2.5-pr206.patch" )
RDEPEND="
	dev-perl/HTTP-Date
	app-admin/VMware-vSphere-CLI
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/LWP-UserAgent-Cached
	dev-perl/Text-Template
	dev-perl/UUID
	dev-perl/Time-Duration
"

src_install(){
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe check_vmware_esx
}
