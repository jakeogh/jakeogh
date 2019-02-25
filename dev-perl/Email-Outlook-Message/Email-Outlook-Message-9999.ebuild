# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# from https://gitlab.com/madsl/fol4/raw/master/dev-perl/Email-Outlook-Message/Email-Outlook-Message-0.919.ebuild

EAPI=6

MODULE_AUTHOR=MVZ

inherit perl-module
inherit git-r3

DESCRIPTION="Read Outlook .msg files"
EGIT_REPO_URI="https://github.com/mvz/email-outlook-message-perl"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-perl/Email-LocalDelivery
	dev-perl/Email-MIME
	dev-perl/Email-Sender
	dev-perl/IO-All
	dev-perl/IO-String
	dev-perl/Module-Build
	dev-perl/OLE-StorageLite
	virtual/perl-Getopt-Long
	virtual/perl-Pod-Parser
	"
DEPEND="${RDEPEND}"

SRC_TEST=do
