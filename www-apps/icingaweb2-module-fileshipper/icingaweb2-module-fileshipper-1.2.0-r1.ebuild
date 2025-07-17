# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Create top-level views of your applications in a graphical editor."
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-fileshipper"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Icinga/${PN}.git"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://codeload.github.com/Icinga/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="php_targets_php8-2 yaml xlsx xml"
PHP_DEPEND="
	php_targets_php8-2? (
		yaml? ( dev-php/pecl-yaml )
		xlsx? ( dev-lang/php:8.2[zip] )
		dev-lang/php:8.2[xml?]
	)
"
RDEPEND="
	www-apps/icingaweb2-module-director
	${PHP_DEPEND}
	"
BDEPEND=""

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
