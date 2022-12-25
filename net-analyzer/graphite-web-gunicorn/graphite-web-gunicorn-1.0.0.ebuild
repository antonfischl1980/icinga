# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for installing graphite-web and running it with gunicorn"
HOMEPAGE="https://github.com/antonfischl1980/icinga"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	acct-user/graphite-web
	net-analyzer/graphite-web[sqlite]
	www-servers/gunicorn
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack(){
	mkdir -p "${S}"
}

src_install(){
	default

	newinitd "${FILESDIR}/graphite-web.initd" "graphite-web"
	newconfd "${FILESDIR}/graphite-web.confd" "graphite-web"
	keepdir /etc/graphite-web/

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/graphite-web.logrotate" "graphite-web"

	keepdir /var/log/graphite-web/
	fowners graphite-web:graphite-web /var/log/graphite-web/
}

pkg_preinst(){
	if [ "$(grep -L '^SECRET_KEY' "${EROOT}/etc/graphite-web/local_settings.py"|wc -l)" -gt 0 ]; then
		# Probably the first time we are installed
		# set some more sane default settings in /etc/graphite-web/local_settings.py

		sed -E "
			s/^(#SECRET_KEY = 'UNSAFE_DEFAULT')/\1\nSECRET_KEY = '$(openssl rand -base64 12|tr -d '/')'/
			s#^(\#TIME_ZONE = 'America/Los_Angeles')#\1\nTIME_ZONE = '$(head -1 /etc/timezone)'#
			s#^(STORAGE_DIR = '/var/lib/carbon')#\#\1\nSTORAGE_DIR = '/var/lib/graphite'#
			s#^(WHISPER_DIR = '/var/lib/carbon/whisper')#\#\1\nWHISPER_DIR = '/var/lib/graphite/whisper/'#
			s#^(RRD_DIR = '/var/lib/carbon/rrd')#\#\1\nRRD_DIR = '/var/lib/graphite/rrd'#
			s#^(\#LOG_ROTATION = True)#\1\nLOG_ROTATION = False#
		" < "${EROOT}/etc/graphite-web/local_settings.py" > "${D}/etc/graphite-web/local_settings.py"
	fi
}

pkg_postinst(){
	chown -R graphite-web:graphite-web "${EROOT}/var/log/graphite-web/"
}
