# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{10..11} )
inherit bash-completion-r1 distutils-r1 git-r3 readme.gentoo-r1
#EGIT_BRANCH="locked_file"
DESCRIPTION="Download videos from YouTube.com (and more sites...)"
HOMEPAGE="https://rg3.github.com/youtube-dl/"
EGIT_REPO_URI="/home/sysskel/myapps/youtube-dl"
#EGIT_BRANCH="write_error"
#EGIT_BRANCH="find_decode"
EGIT_BRANCH="locked_file"
LICENSE="public-domain"
KEYWORDS=""
SLOT="0"
IUSE="test"
RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"

src_compile() {
	distutils-r1_src_compile

	emake ${PN}.{bash-completion,fish,zsh}
}

python_test() {
	emake offlinetest
}

python_install_all() {
	dodoc README.md

	newbashcomp ${PN}.bash-completion ${PN}

	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}

	insinto /usr/share/fish/vendor_completions.d
	doins ${PN}.fish

	distutils-r1_python_install_all

	rm -r "${ED}"/usr/etc || die
	rm -r "${ED}"/usr/share/doc/youtube_dl || die
}

pkg_postinst() {
	elog "${PN}(1) / https://bugs.gentoo.org/355661 /"
	elog "https://github.com/rg3/${PN}/blob/master/README.md#faq :"
	elog
	elog "${PN} works fine on its own on most sites. However, if you want"
	elog "to convert video/audio, you'll need ffmpeg (media-video/ffmpeg)."
	elog "On some sites - most notably YouTube - videos can be retrieved in"
	elog "a higher quality format without sound. ${PN} will detect whether"
	elog "ffmpeg is present and automatically pick the best option."
	elog
	elog "Videos or video formats streamed via RTMP protocol can only be"
	elog "downloaded when rtmpdump (media-video/rtmpdump) is installed."
	elog
	elog "Downloading MMS and RTSP videos requires either mplayer"
	elog "(media-video/mplayer) or mpv (media-video/mpv) to be installed."
	elog
	elog "If you want ${PN} to embed thumbnails from the metadata into the"
	elog "resulting MP4 files, consider installing media-video/atomicparsley"
}
