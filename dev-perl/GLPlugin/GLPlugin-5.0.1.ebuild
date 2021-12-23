# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-functions
inherit git-r3

DESCRIPTION="Perl modules providing the basis for labs.consol.de Nagios/Naemon/Icinga plugins"
HOMEPAGE="https://github.com/lausser/GLPlugin"
EGIT_REPO_URI="https://github.com/lausser/GLPlugin.git"
EGIT_COMMIT="57d26f4a9de48dcfeb2a945890979672c2fbc011"

PATCHES=(
	"${FILESDIR}"/01_snmp_timeout.patch
)

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-perl/JSON
"
DEPEND=""

src_configure(){
	default

	echo '1;'> autosplit.ix
}

src_install(){
	default

	my_vendorlib="$(perl_get_vendorlib)"

	insinto ${my_vendorlib}/auto/Monitoring/GLPlugin/UPNP/
	doins autosplit.ix
	insinto ${my_vendorlib}/auto/Monitoring/GLPlugin/SNMP/
	doins autosplit.ix

	pushd lib/Monitoring
	perl_domodule -C Monitoring -r .
	popd
}
