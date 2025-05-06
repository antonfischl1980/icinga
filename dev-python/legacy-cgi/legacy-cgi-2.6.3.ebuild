# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="Fork of the standard library cgi and cgitb modules removed in Python 3.13"
HOMEPAGE="
	https://pypi.org/project/legacy-cgi/
"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
"
BDEPEND="
"

distutils_enable_tests pytest
