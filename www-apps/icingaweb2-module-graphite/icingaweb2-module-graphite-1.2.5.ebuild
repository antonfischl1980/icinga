# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Module for displaying Graphite data directly in Icinga Web 2"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-graphite/"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Icinga/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://codeload.github.com/Icinga/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

PATCHES=(
	"${FILESDIR}/icingaweb2-GraphDisapear-issue-4996.patch"
)

IUSE="php_targets_php8-2 php_targets_php8-3"
PHP_DEPEND="
	php_targets_php8-2? ( dev-lang/php:8.2[curl] )
	php_targets_php8-3? ( dev-lang/php:8.3[curl] )
"
RDEPEND="
	${PHP_DEPEND}
	>=dev-libs/icinga-php-library-0.13.0
	>=dev-libs/icinga-php-thirdparty-0.12.0
	>=www-apps/icingaweb2-2.9.0
	"
DEPEND=""

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*
}
