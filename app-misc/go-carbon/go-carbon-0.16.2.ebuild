# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Golang implementation of Graphite/Carbon server with classic architecture"
HOMEPAGE="https://github.com/go-graphite/go-carbon"

SRC_URI="https://github.com/go-graphite/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	acct-group/carbon
	acct-user/carbon
	>=dev-lang/go-1.8
	app-admin/logrotate
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	dosbin go-carbon
	keepdir /etc/go-carbon
	keepdir /var/log/go-carbon
	newdoc go-carbon.conf.example go-carbon.conf.example
	newdoc deploy/storage-aggregation.conf storage-aggregation.conf.sample
	newdoc deploy/storage-schemas.conf storage-schemas.conf.sample
	newinitd "${FILESDIR}/go-carbon.initd" "${PN}"
	insinto /etc/logrotate.d/
	newins "${FILESDIR}/go-carbon.logrotate" "${PN}"
}

pkg_config(){
	cd "${ROOT}"/etc/go-carbon/
	if [ ! -f "${ROOT}"/etc/go-carbon/go-carbon.conf ];then
		unpack "${ROOT}"/usr/share/doc/${PF}/go-carbon.conf.example.bz2
		mv go-carbon.conf.sample go-carbon.conf
	fi
	if [ ! -f "${ROOT}"/etc/go-carbon/storage-aggregation.conf ];then
		unpack "${ROOT}"/usr/share/doc/${PF}/storage-aggregation.conf.sample.bz2
		mv storage-aggregation.conf.sample storage-aggregation.conf
	fi
	if [ ! -f "${ROOT}"/etc/go-carbon/storage-schemas.conf ];then
		unpack "${ROOT}"/usr/share/doc/${PF}/storage-schemas.conf.sample.bz2
		mv storage-schemas.conf.sample storage-schemas.conf
	fi
}
