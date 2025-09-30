# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Python Linear Programming API for optimization"
HOMEPAGE="https://coin-or.github.io/pulp/ https://github.com/coin-or/pulp"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/coin-or/pulp.git"
else
	SRC_URI="https://github.com/coin-or/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

# Solver support - all optional
# PuLP bundles CBC binaries by default, but you can use external solvers
IUSE="glpk +cbc cplex gurobi"

# No mandatory runtime dependencies
# Optional solver dependencies
RDEPEND="
	glpk? ( sci-mathematics/glpk )
	cbc? ( sci-libs/coinor-cbc )
"

# Test dependencies
BDEPEND="
	test? (
		glpk? ( sci-mathematics/glpk )
	)
"

distutils_enable_tests pytest

python_test() {
	# Run pulptest which tests available solvers
	"${EPYTHON}" -m pytest -vv || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	elog "PuLP is a Linear Programming modeler for Python."
	elog ""
	elog "PuLP bundles the CBC solver by default, but you can use"
	elog "various external solvers by installing them separately:"
	elog "  - GLPK: emerge sci-mathematics/glpk"
	elog "  - CBC: emerge sci-libs/coinor-cbc"
	elog "  - CPLEX/Gurobi: Install manually (commercial)"
	elog ""
	elog "To test solver availability, run: python -c 'import pulp; print(pulp.listSolvers(onlyAvailable=True))'"
}
