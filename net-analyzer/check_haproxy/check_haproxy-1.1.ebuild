# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="checks haproxy including performance data"
HOMEPAGE="https://github.com/men-crt-sup/nagios-plugins"
SRC_URI=""
EGIT_REPO_URI="https://github.com/men-crt-sup/nagios-plugins.git"
EGIT_COMMIT="62fd8d5225f3553a7f1c64b1e0974c42ec5167f1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/perl
	dev-perl/Locale-gettext
	virtual/perl-Time-HiRes
	"
BDEPEND=""

src_install() {
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe check_haproxy.pl

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/check_haproxy_pl.conf"
}
