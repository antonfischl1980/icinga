# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="checks if HPE controllers an SSDs are not affected by certain vulnerabilities"
HOMEPAGE="https://github.com/NETWAYS/check_hp_firmware"

EGO_SUM=(
"github.com/NETWAYS/go-check v0.1.0 h1:71jwwcxNwWpLEtzr8FlysyqMwQXRKX+vhNsbNvVRxKI="
"github.com/NETWAYS/go-check v0.1.0/go.mod h1:1io7Dj72xdHEsa3ZU7oCbvUSi+QjTT/u863gfuvU3+s="
"github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
"github.com/davecgh/go-spew v1.1.1 h1:vj9j/u1bqnvCEfJOwUhtlOARqs3+rkHYY13jYWTU97c="
"github.com/davecgh/go-spew v1.1.1/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
"github.com/golang/mock v1.4.4/go.mod h1:l3mdAwkq5BuhzHwde/uurv3sEJeZMXNpwsxVWU71h+4="
"github.com/gosnmp/gosnmp v1.32.0 h1:gctewmZx5qFI0oHMzRnjETqIZ093d9NgZy9TQr3V0iA="
"github.com/gosnmp/gosnmp v1.32.0/go.mod h1:EIp+qkEpXoVsyZxXKy0AmXQx0mCHMMcIhXXvNDMpgF0="
"github.com/hashicorp/go-version v1.3.0 h1:McDWVJIU/y+u1BRV06dPaLfLCaT7fUTJLp5r04x7iNw="
"github.com/hashicorp/go-version v1.3.0/go.mod h1:fltr4n8CU8Ke44wwGCBoEymUuxUHl09ZGVZPK5anwXA="
"github.com/jarcoal/httpmock v1.0.8/go.mod h1:ATjnClrvW/3tijVmpL/va5Z3aAyGvqU3gCT8nX0Txik="
"github.com/mcuadros/go-version v0.0.0-20190830083331-035f6764e8d2 h1:YocNLcTBdEdvY3iDK6jfWXvEaM5OCKkjxPKoJRdB3Gg="
"github.com/mcuadros/go-version v0.0.0-20190830083331-035f6764e8d2/go.mod h1:76rfSfYPWj01Z85hUf/ituArm797mNKcvINh1OlsZKo="
"github.com/mitchellh/go-ps v1.0.0 h1:i6ampVEEF4wQFF+bkYfwYgY+F/uYJDktmvLPf7qIgjc="
"github.com/mitchellh/go-ps v1.0.0/go.mod h1:J4lOc8z8yJs6vUwklHw2XEIiT4z4C40KtWVN3nvg8Pg="
"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
"github.com/sirupsen/logrus v1.8.1 h1:dJKuHgqk1NNQlqoA6BTlM1Wf9DOH3NBjQyu0h9+AZZE="
"github.com/sirupsen/logrus v1.8.1/go.mod h1:yWOB1SBYBC5VeMP7gHvWumXLIWorT60ONWic61uBYv0="
"github.com/spf13/pflag v1.0.5 h1:iy+VFUOCP1a+8yFto/drg2CJ5u0yRoB7fZw3DKv/JXA="
"github.com/spf13/pflag v1.0.5/go.mod h1:McXfInJRrz4CZXVZOBLb0bTZqETkiAhM9Iw0y3An2Bg="
"github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME="
"github.com/stretchr/testify v1.2.2/go.mod h1:a8OnRcib4nhh0OaRAV+Yts87kKdq0PP7pXfy6kDkUVs="
"github.com/stretchr/testify v1.7.0 h1:nwc3DEeHmmLAfoZucVR881uASk0Mfjw8xYJ99tb5CcY="
"github.com/stretchr/testify v1.7.0/go.mod h1:6Fq8oRcR53rry900zMqJjRRixrwX3KX962/h/Wwjteg="
"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod h1:djNgcEr1/C05ACkg1iLfiJU5Ep61QUkGW8qpdssI0+w="
"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod h1:t9HGtf8HONx5eT2rtn7q6eTqICYqUVnKs3thJo3Qplg="
"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY="
"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
"golang.org/x/sys v0.0.0-20210514084401-e8d321eab015 h1:hZR0X1kPW+nwyJ9xRxqZk1vx5RUObAPBdKVvXPDUH/E="
"golang.org/x/sys v0.0.0-20210514084401-e8d321eab015/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg="
"golang.org/x/text v0.3.0/go.mod h1:NqM8EUOU14njkJ3fqMW+pc6Ldnwhi/IjpwHt7yyuwOQ="
"golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q="
"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405 h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM="
"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0="
"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c h1:dUUwHk2QECo/6vqA44rthZ8ie2QXMNeKRTHCNY2nXvo="
"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM="
)

go-module_set_globals

SRC_URI="https://github.com/NETWAYS/check_hp_firmware/archive/refs/tags/v1.3.0.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="GPL-2 MIT BSD MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	exeinto /usr/lib64/nagios/plugins/contrib/
	use amd64 && newexe "build/${PN}-amd64" "${PN}"
	use x86 && newexe "build/${PN}-i386" "${PN}"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	newins icinga2.conf "${PN}".conf
}
