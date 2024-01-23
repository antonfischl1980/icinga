# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Create top-level views of your applications in a graphical editor."
HOMEPAGE="https://github.com/nbuchwitz/icingaweb2-module-map/"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nbuchwitz/${PN}.git"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://codeload.github.com/nbuchwitz/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="php_targets_php8-1"
PHP_DEPEND="
	php_targets_php8-1? ( dev-lang/php:8.1[curl] )
"
RDEPEND="
	>=www-apps/icingaweb2-2.9.0
	>=dev-libs/icinga-php-library-0.9.0
	${PHP_DEPEND}
	"
DEPEND=""

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
