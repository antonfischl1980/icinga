# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="naglio-plugins"
COMMIT="4011ea1507eefa35a07ee11a3035a276d6c1fae0"
DESCRIPTION="Redis Check for Nagios/Icinga2"
HOMEPAGE="http://william.leibzon.org/nagios/"
SRC_URI="https://github.com/willixix/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

DEPEND="
	dev-perl/Redis
	dev-perl/Monitoring-Plugin
	virtual/perl-Getopt-Long
	virtual/perl-Socket
	virtual/perl-Text-ParseWords
	virtual/perl-Time-HiRes
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/
	doexe check_redis.pl

	insinto /etc/icingaweb2/modules/graphite/templates/
	newins "${FILESDIR}/redis.template" "redis.ini"
}
