# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="A command line tool to interact with Gitea servers"
HOMEPAGE="https://gitea.com/gitea/tea"
SRC_URI="
	https://gitea.com/gitea/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/antonfischl1980/gentoo-go-vendored-ci/releases/download/dev-util%2F${P}-deps/${P}-deps.tar.xz
"
S="${WORKDIR}/${PN}"
LICENSE="MIT Apache-2.0 BSD MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND=""
DEPEND="${BDEPEND}"
RDEPEND="${DEPEND}"

src_compile(){
	ego build
}

src_install(){
	dobin "${PN}"
	dodoc ./*.md

	newbashcomp contrib/autocomplete.sh "${PN}"
	insinto /usr/share/zsh/site-functions
	newins contrib/autocomplete.zsh "_${PN}"
}
