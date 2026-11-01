# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga Web 2 plugin for configuration"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-director/"
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

# Dependencies according to https://github.com/Icinga/icingaweb2-module-director/blob/master/doc/02-Installation.md
IUSE="php_targets_php8-2 php_targets_php8-3 php_targets_php8-4 php_targets_php8-5"
PHP_DEPEND="
	php_targets_php8-2? ( dev-lang/php:8.2[curl,iconv,pcntl,posix,sockets] )
	php_targets_php8-3? ( dev-lang/php:8.3[curl,iconv,pcntl,posix,sockets] )
	php_targets_php8-4? ( dev-lang/php:8.4[curl,iconv,pcntl,posix,sockets] )
	php_targets_php8-5? ( dev-lang/php:8.5[curl,iconv,pcntl,posix,sockets] )
"
RDEPEND="
	${PHP_DEPEND}
	>=dev-libs/icinga-php-legacy-1.1.0
	>=dev-libs/icinga-php-library-1.0.0
	>=dev-libs/icinga-php-thirdparty-1.0.0
	>=www-apps/icingaweb2-2.14.0
	"
DEPEND=""

src_install() {
	insinto "/usr/share/icingaweb2/modules/${PN##*-}/"
	doins -r "${S}"/*

	exeinto /usr/share/icingaweb2/bin/
	doexe "${FILESDIR}/icinga-director.sh"

	doinitd "${FILESDIR}/director"
}

pkg_postinst() {
	# According to PMS this can be a space-separated list of version
	# numbers, even though in practice it is typically just one.
	local oldver
	for oldver in ${REPLACING_VERSIONS}; do
		if ver_test "${oldver}" -lt "1.11.7"; then
			ewarn "You are upgrading from $oldver to ${PVR}"
			ewarn "please read https://github.com/Icinga/icingaweb2-module-director/blob/master/doc/05-Upgrading.md#upgrade-to-1.11.x"
			ewarn "for breaking changes"
			ewarn ""
			ewarn "Also, don't forget to upgrade database schema."
			ewarn "Otherwise icingaweb2-module-director will not work!"
			ewarn "(Web GUI => Configuration => Modules => director => Configuration)"
			ewarn ""
			break
		fi
	done
}
