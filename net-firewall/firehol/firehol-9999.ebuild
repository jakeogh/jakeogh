# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit linux-info

DESCRIPTION="iptables firewall generator"
HOMEPAGE="https://github.com/firehol/firehol"
EGIT_REPO_URI="https://github.com/firehol/firehol.git"
inherit git-r3

LICENSE="GPL-2"
SLOT="0"
IUSE="doc ipv6 ipset"
KEYWORDS="~amd64 ~arm ~ppc"
MAKEOPTS+=" -j1" #man pages fail to build in parallel

RDEPEND="net-firewall/iptables
	sys-apps/iproute2[-minimal,ipv6?]
	net-misc/iputils[ipv6?]
	net-misc/iprange
	net-analyzer/traceroute
	virtual/modutils
	app-arch/gzip
	ipset? (
		net-firewall/ipset
	)
	doc? (
		app-text/pandoc
	)"
DEPEND="${RDEPEND}"

pkg_setup() {
	local KCONFIG_OPTS=" \
		~IP_NF_FILTER \
		~IP_NF_IPTABLES \
		~IP_NF_MANGLE \
		~IP_NF_TARGET_MASQUERADE
		~IP_NF_TARGET_REDIRECT \
		~IP_NF_TARGET_REJECT \
		~NETFILTER_XT_MATCH_LIMIT \
		~NETFILTER_XT_MATCH_OWNER \
		~NETFILTER_XT_MATCH_STATE \
		~NF_CONNTRACK \
		~NF_CONNTRACK_IPV4 \
		~NF_CONNTRACK_MARK \
		~NF_NAT \
		~NF_NAT_FTP \
		~NF_NAT_IRC \
	"
	linux-info_pkg_setup
}

src_prepare() {
        default
        ./autogen.sh || die
}

src_configure() {
	econf \
		--disable-vnetbuild \
		$(use_enable ipset update-ipsets) \
		$(use_enable doc) \
		$(use doc || echo --disable-man) \
		$(use doc && echo --enable-maintainer-mode) \
		$(use_enable ipv6)
}

src_install() {
	default

	newconfd "${FILESDIR}"/firehol.conf.d firehol
	newinitd "${FILESDIR}"/firehol.initrd firehol
	newconfd "${FILESDIR}"/fireqos.conf.d fireqos
	newinitd "${FILESDIR}"/fireqos.initrd fireqos
}
