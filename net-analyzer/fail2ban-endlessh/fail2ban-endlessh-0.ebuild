# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_COMMIT="0a55f4a2bfd3c948661b0b689dedfd27b606aa31"
DESCRIPTION="Combining the powers of endlessh and fail2ban."
HOMEPAGE="https://github.com/itskenny0/fail2ban-endlessh"
SRC_URI="https://github.com/itskenny0/fail2ban-endlessh/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

PATCHES=(
        "${FILESDIR}"/iptables-fix-pr5.patch
)

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	net-analyzer/fail2ban
	net-misc/endlessh
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default

	insinto /etc/fail2ban/action.d/
	doins action.d/endlessh.conf

	insinto /etc/fail2ban/jail.d/
	doins jail.d/endlessh.conf
}

pkg_postinst(){
	elog "to activate fail2ban-endlessh, put these lines into /etc/fail2ban/jail.local:"
	elog "[sshd]"
	elog "enabled = true"
	elog ""
	elog "also, you have to enable both endlessh and fail2ban service (i.e.: rc-update add endlessh; rc-update add fail2ban )"
}
