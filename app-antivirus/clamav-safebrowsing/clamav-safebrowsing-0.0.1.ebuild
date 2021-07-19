# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7..10} )
inherit distutils-r1 git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/Cisco-Talos/clamav-safebrowsing"
EGIT_REPO_URI="https://github.com/Cisco-Talos/clamav-safebrowsing.git"
EGIT_COMMIT="bcc46768b74c34fe806c4123cf792a47b79eca34"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="
	dev-python/apacheconfig
	dev-python/google-api-python-client
	dev-python/mysqlclient
	dev-python/sqlalchemy
"

distutils_enable_tests pytest

python_install_all(){
	insinto /etc/clamav/
	doins etc/safebrowsing.conf.sample

	keepdir /var/db/safebrowsing/output/
}

