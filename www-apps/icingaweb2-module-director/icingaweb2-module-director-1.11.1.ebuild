# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga Web 2 plugin for configuration"
HOMEPAGE="https://github.com/Icinga/icingaweb2-module-director/"
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

# Dependencies according to https://github.com/Icinga/icingaweb2-module-director/blob/master/doc/02-Installation.md
IUSE="php_targets_php8-1 php_targets_php8-2"
PHP_DEPEND="
	php_targets_php8-1? ( dev-lang/php:8.1[curl,iconv,pcntl,posix,sockets] )
	php_targets_php8-2? ( dev-lang/php:8.2[curl,iconv,pcntl,posix,sockets] )
"
RDEPEND="
	${PHP_DEPEND}
	>=www-apps/icingaweb2-module-incubator-0.20.0
	>=dev-libs/icinga-php-library-0.5.0
	>=dev-libs/icinga-php-thirdparty-0.9.0
	>=www-apps/icingaweb2-2.9.0
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
		if ver_test "${oldver}" -lt "1.11.0"; then
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
