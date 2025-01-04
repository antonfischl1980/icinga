# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit depend.apache

DESCRIPTION="Icinga Web 2 - Frontend for icinga2"
HOMEPAGE="http://www.icinga.org/"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Icinga/icingaweb2.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://codeload.github.com/Icinga/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="apache2 apache2-server fpm ldap mysql nginx pdf postgres"
REQUIRED_USE="( ?? ( apache2-server nginx ) ) apache2? ( apache2-server )"

IUSE="${IUSE} php_targets_php8-2 php_targets_php8-3"
PHP_DEPEND="
	php_targets_php8-2? (
		dev-lang/php:8.2[apache2?,cli,curl,fileinfo,fpm?,gd,intl,ldap?,mysql?,nls,pdo,postgres?,sockets,ssl,xslt,xml]
	)
	php_targets_php8-3? (
		dev-lang/php:8.3[apache2?,cli,curl,fileinfo,fpm?,gd,intl,ldap?,mysql?,nls,pdo,postgres?,sockets,ssl,xslt,xml]
	)
"
DEPEND=">=net-analyzer/icinga2-2.1.1
		dev-php/pecl-imagick
		pdf? ( media-gfx/imagemagick[png] )
		apache2-server? ( >=www-servers/apache-2.4.0 )
		nginx? ( >=www-servers/nginx-1.7.0:* )
		${PHP_DEPEND}
		>=dev-libs/icinga-php-library-0.13.0
		>=dev-libs/icinga-php-thirdparty-0.12.0
		acct-group/icingacmd
		acct-group/icingaweb2"
RDEPEND="${DEPEND}
	apache2? ( acct-user/apache[icingaweb2] )
	nginx? ( acct-user/nginx[icingaweb2] )
"

pkg_config() {
	if [[ -d /etc/icingaweb2 ]] ; then
		einfo "Updating existing installation ..."
	else
		einfo "Running first time setup ..."
		einfo "Creating configuration directory ..."
		/usr/share/"${PN}"/bin/icingacli setup config directory
		einfo "Creating authentication token for web setup ..."
		/usr/share/"${PN}"/bin/icingacli setup token create
		if use apache2 ; then
			einfo "The following might be useful for your Apache2 configuration:"
			/usr/share/"${PN}"/bin/icingacli setup config webserver apache --document-root /usr/share/"${PN}"/public
		fi
		if use nginx ; then
			einfo "The following might be useful for your NGinx configuration:"
			/usr/share/"${PN}"/bin/icingacli setup config webserver nginx --document-root /usr/share/"${PN}"/public
		fi
	fi
	einfo "All done."
}

src_install() {
	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/logrotate "${PN}"
	insinto "/usr/share/${PN}"
	doins -r "${S}"/*
	fperms -R a+rX "/usr/share/${PN}/public/"
	fperms u+x,g+x "/usr/share/${PN}/bin/icingacli"
	fowners root:icingaweb2 "/usr/share/${PN}/bin/icingacli"
	dosym "../share/${PN}/bin/icingacli" /usr/bin/icingacli
	dosym "../share/${PN}/bin/icingacli" /usr/sbin/icingacli
	dosym "../../usr/share/${PN}/etc/bash_completion.d/icingacli" /etc/bash_completion.d/icingacli
	keepdir /var/lib/"${PN}"
	keepdir /var/log/"${PN}"
	fowners nobody:icingaweb2 /var/{lib,log}/"${PN}"
	fperms g+w /var/{lib,log}/"${PN}"
}

pkg_postinst() {
	einfo "Run 'emerge --config =${CATEGORY}/${PF}' to finish setup."
}
