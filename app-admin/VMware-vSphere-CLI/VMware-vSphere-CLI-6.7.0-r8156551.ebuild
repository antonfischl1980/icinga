# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="VMware vSphere Command Line Interface 6.7"
HOMEPAGE="https://my.vmware.com/de/web/vmware/details?downloadGroup=VS-CLI-670&productId=742"
SRC_URI="VMware-vSphere-CLI-6.7.0-8156551.x86_64.tar.gz"
RESTRICT="fetch mirror"

PATCHES=(
	"${FILESDIR}"/Makefile.PL.patch
)

LICENSE="VMware-vSphere-CLI-EULA"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
	dev-perl/Archive-Zip
	dev-perl/HTTP-Date
	dev-perl/LWP-UserAgent-Cached
	dev-perl/Text-Template
	dev-perl/Time-Duration
	dev-perl/URI
	dev-perl/UUID
	dev-perl/XML-LibXML
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

pkg_nofetch(){
	default
	einfo "Please download ${A} from $HOMEPAGE"
	einfo "and place it in your DISTDIR (usually /var/cache/distfiles/ or /usr/portage/distfiles/ )"
	einfo "you will need a VMware Account for this"
}

src_unpack() {
	default
	mv "${WORKDIR}/vmware-vsphere-cli-distrib" "${S}"
}

src_install() {
	default
	dobin bin/[r-z]*
	cd "${D}/usr/bin" || die
	for i in vicfg-*;do
		ln -s "$i" "${i//vicfg-/esxcfg-}"
	done
	keepdir "/usr/share/doc/${PF}/"
	mv "${D}/usr/doc/"* "${D}/usr/share/doc/${PF}/"
	rm -R "${D}/usr/doc/"
}
