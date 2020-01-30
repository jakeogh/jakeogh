# Copyright 2016, 2019 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rindeal-utils.eclass
# @BLURB: Collection of handy general purpose functions
# @DESCRIPTION:


if ! (( _RINDEAL_UTILS_ECLASS ))
then

case "${EAPI:-0}" in
'6' | '7' ) ;;
* ) die "EAPI='${EAPI}' is not supported by '${ECLASS}' eclass" ;;
esac

inherit rindeal


# TODO: remove this function
rindeal:expand_vars() {
	local f_in="${1}"
	local f_out="${2}"
	(( $# > 2 || $# < 1 )) && die

	local sed_args=()
	local v vars=( $( grep -o '@[A-Z_][A-Z0-9_]*@' -- "${f_in}" | tr -d '@') )
	for v in "${vars[@]}"
	do
		if [[ -v "${v}" ]]
		then
			sed_args+=( -e "s|@${v}@|${!v}|g" )
		else
			einfo "${FUNCNAME}: var '${v}' doesn't exist"
		fi
	done

	local basedir="$(dirname "${WORKDIR}")"
	echo "Converting '${f_in#"${basedir}/"}' -> '${f_out#"${basedir}/"}"

	rsed "${sed_args[@]}" -- "${f_in}" >"${f_out}"
}

rindeal:prefix_flags() {
	(( $# < 2 )) && die

	local prefix="$1" ; shift
	local flags=( "$@" )
	local regex="^([+-])?([a-zA-Z][a-zA-Z0-9_-]*[a-zA-Z0-9])"

	local x
	for x in "${flags[@]}"
	do
		[[ "${x}" =~ ${regex} ]] || die
		local sign="${BASH_REMATCH[1]}" flag="${BASH_REMATCH[2]}"
		printf "%s%s%s\n" "${sign}" "${prefix}" "${flag}"
	done
}

rindeal:filter_A() {
	(( $# < 1 )) && die

	local -A blacklist=()
	local -a A_new=()

	## create deduplicated hashtable for quick lookups
	local path
	for path in "${@}"
	do
		local filename="${path##*/}"
		blacklist["${filename}"]=
	done

	local filename
	for filename in ${A}
	do
		if [[ -v blacklist["${filename}"] ]]
		then
			unset blacklist["${filename}"]
		else
			A_new+=( "${filename}" )
		fi
	done

	A="${A_new[*]}"
}

rindeal:has_version() {
	local atom root="${ROOT%/}/${EPREFIX#/}" root_arg
	local -a cmd=()

	case "${1}" in
	--host-root | -r | -d | -b )
		root_arg="${1}"
		shift
		;;
	esac
	atom="${1}"
	shift
	(( $# > 0 )) && die "${FUNCNAME[1]}: unused argument(s): $*"

	case ${root_arg} in
		--host-root)
			# Since portageq requires the root argument be consistent
			# with EPREFIX, ensure consistency here (bug 655414).
			root="/${PORTAGE_OVERRIDE_EPREFIX#/}"
			cmd+=( env EPREFIX="${PORTAGE_OVERRIDE_EPREFIX}" )
			;;
		-r|-d|-b)
			case ${root_arg} in
				-r) root="${ROOT%/}/${EPREFIX#/}" ;;
				-d) root="${ESYSROOT}" ;;
				-b)
					# Use /${PORTAGE_OVERRIDE_EPREFIX#/} which is equivalent
					# to BROOT, except BROOT is only defined in src_* phases.
					root="/${PORTAGE_OVERRIDE_EPREFIX#/}"
					cmd+=( env EPREFIX="${PORTAGE_OVERRIDE_EPREFIX}" )
					;;
			esac
	esac

	### BEGIN: patched section
	# these variables cause the helpers mark `*::repo` expressions as invalid package atom
	cmd+=( env -u EBUILD_PHASE -u EAPI )
	### END: patched section

	if [[ -n $PORTAGE_IPC_DAEMON ]]
	then
		cmd+=( "${PORTAGE_BIN_PATH}"/ebuild-ipc "${FUNCNAME[1]}" "${root}" "${atom}" )
	else
		cmd+=( "${PORTAGE_BIN_PATH}"/ebuild-helpers/portageq "${FUNCNAME[1]}" "${root}" "${atom}" )
	fi
	"${cmd[@]}"
	local retval=$?
	case "${retval}" in
		0 | 1 )
			return ${retval}
			;;
		2 )
			die "${FUNCNAME[1]}: invalid atom: ${atom}"
			;;
		* )
			if [[ -n ${PORTAGE_IPC_DAEMON} ]]
			then
				die "${FUNCNAME[1]}: unexpected ebuild-ipc exit code: ${retval}"
			else
				die "${FUNCNAME[1]}: unexpected portageq exit code: ${retval}"
			fi
			;;
	esac
}


_RINDEAL_UTILS_ECLASS=1
fi
