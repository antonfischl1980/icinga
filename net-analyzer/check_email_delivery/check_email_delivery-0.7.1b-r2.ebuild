# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Check Email Delivery is a plugin for Nagios"
HOMEPAGE="http://buhacoff.net/software/check_email_delivery/index.html"
SRC_URI="http://buhacoff.net/software/check_email_delivery/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
${DEPEND}
dev-perl/Mail-IMAPClient
"
BDEPEND=""

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe imap*
	doexe check*
	dodoc docs/*

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
