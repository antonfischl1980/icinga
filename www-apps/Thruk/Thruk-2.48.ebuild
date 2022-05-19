# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="multibackend monitoring webinterface for Nagios/Icinga and others"
HOMEPAGE="https://www.thruk.org"
SRC_URI="https://github.com/sni/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64"

PATCHES=(
	"${FILESDIR}/01-threads.patch"
)

DEPEND="
	dev-perl/Cpanel-JSON-XS
	dev-perl/Date-Calc
	dev-perl/forks
	dev-perl/thruk_libs
	www-apache/mod_fcgid
	www-client/phantomjs-bin
	www-servers/apache
	"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-perl/Module-Install
	"

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}"/etc/"${PN}" \
		--datadir="${EPREFIX}"/usr/share/"${PN}" \
		--localstatedir="${EPREFIX}"/var/lib/"${PN}" \
		--with-initdir="${EPREFIX}"/usr/share/"${PN}"/etc/init.d/ \
		--with-tempdir="${EPREFIX}"/usr/share/"${PN}"/tmp/ \
		--with-logrotatedir="${EPREFIX}"/etc/logrotate.d \
		--with-logdir="${EPREFIX}"/var/log/"${PN}" \
		--with-thruk-user=apache \
		--with-thruk-group=apache
}

src_install() {
	default

	mv "${D}/etc/Thruk/thruk_local.conf" "${D}/etc/Thruk/thruk_local.conf.example"

	insinto /etc/apache2/vhosts.d/
	newins "${FILESDIR}/apache_thruk.conf.example" thruk.conf.example

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/thruk-base.lograte" thruk-base

	keepdir /var/log/"${PN}"
	fowners apache:apache /var/log/Thruk/
	keepdir /usr/share/"${PN}"/var/

	exeinto /usr/share/"${PN}"/bin/
	doexe script/*.pl
	doexe script/*.sh
	doexe script/[cdegnrt]*

	keepdir /usr/share/Thruk/tmp
	fowners apache:apache /usr/share/Thruk/tmp

	keepdir /etc/Thruk/panorama/
	fowners apache:apache /etc/Thruk/panorama/
	keepdir /var/lib/Thruk/
	fowners apache:apache /var/lib/Thruk/
	keepdir /var/lib/Thruk/sessions/
	fowners apache:apache /var/lib/Thruk/sessions/
	keepdir /var/lib/Thruk/users/
	fowners apache:apache /var/lib/Thruk/users/
}

pkg_preinst(){
	if [ "$(grep -L '^APACHE2_OPTS=.*-DFCGID' "${EROOT}/etc/conf.d/apache2"|wc -l)" -gt 0 ]; then
		# Probably the first time we are installed
		# set some more sane default settings in /etc/conf.d/apache2

		mkdir -p "${D}/etc/conf.d/"
		sed -E '
			s#^(APACHE2_OPTS\s*=\s*")([^"]+)(")#\1\2 -D FCGID\3#
		' < "${EROOT}/etc/conf.d/apache2" > "${D}/etc/conf.d/apache2"
	fi

	if [ ! -r "${EROOT}/etc/Thruk/thruk_local.conf" ]; then
		# Probably the first time we are installed
		cp "${D}/etc/Thruk/thruk_local.conf.example" "${D}/etc/Thruk/thruk_local.conf"
	fi
}
