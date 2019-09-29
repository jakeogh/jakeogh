# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/erroneousboat/${PN}"

inherit git-r3 golang-vcs-snapshot

DESCRIPTION="A Slack client for your terminal"
HOMEPAGE="https://github.com/erroneousboat/slack-term"
#SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror test" # No tests available yet
EGIT_REPO_URI="https://github.com/erroneousboat/slack-term.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="" # Untested: arm arm64 x86
IUSE="debug pie"

DOCS=( README.md )
QA_PRESTRIPPED="usr/bin/.*"

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

src_compile() {
	export GOPATH="${G}"
	local mygoargs=(
		-v -work -x
		"-buildmode=$(usex pie pie exe)"
		"-asmflags=all=-trimpath=${S}"
		"-gcflags=all=-trimpath=${S}"
		-ldflags "$(usex !debug '-s -w' '')"
	)
	go build "${mygoargs[@]}" || die
}

src_test() {
	go test -v -race ./... || die
}

src_install() {
	dobin slack-term
	einstalldocs

	use debug && dostrip -x /usr/bin/slack-term
}
