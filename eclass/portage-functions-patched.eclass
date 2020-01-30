# Copyright 2016, 2019 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: portage-functions-patched.eclass
# @BLURB: Set of portage functions overrides

case "${EAPI:-"0"}" in
"6" | "7" ) ;;
* ) die "EAPI='${EAPI}' is not supported by ECLASS='${ECLASS}'" ;;
esac


## Origin: portage - bin/isolated-functions.sh
rindeal:has() {
	local -r -- IFS=$'\a'

	[[ "${IFS}${*:2}${IFS}" == *"${IFS}${1}${IFS}"* ]]
}
has() { rindeal:has "${@}" ; }
