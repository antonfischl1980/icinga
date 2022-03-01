# Copyright 2022+ Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="d159c3278a876d2accccf6c8147b03d19847a805"

DESCRIPTION="plugin that checks a CRL distribution point (CDP) over HTTP. "
HOMEPAGE="https://github.com/kerard/check_crl"
SRC_URI="https://github.com/kerard/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86 x64-cygwin amd64-linux x86-linux ppc-macos x64-macos sparc-solaris sparc64-solaris x64-solaris x86-solaris"

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-libs/openssl
	net-misc/curl
	"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe check_crl.sh

	dodoc README.md

	insinto /usr/share/icinga2/include/plugins-contrib.d
	doins "${FILESDIR}/check_crl.conf"
}
