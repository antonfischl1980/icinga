# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-functions

EGIT_COMMIT="3d6703967354973793ddc0c90673af0143805749"
DESCRIPTION="Perl modules providing the basis for labs.consol.de Nagios/Naemon/Icinga plugins"
HOMEPAGE="https://github.com/lausser/GLPlugin"
SRC_URI="https://github.com/lausser/GLPlugin/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

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
