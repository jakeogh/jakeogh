# Copyright 2016-2019 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rindeal.eclass
# @BLURB: Base eclass for all ebuilds
# @DESCRIPTION:
#   This eclass should be inheritted by all ebuilds right after the EAPI specification before any inherits.


# fight with portage and override it again and again
inherit portage-functions-patched


if ! (( _RINDEAL_ECLASS ))
then

case "${EAPI:-0}" in
'6' | '7' ) ;;
* ) die "EAPI='${EAPI}' is not supported by '${ECLASS}' eclass" ;;
esac


rindeal:func_exists() {
	declare -F "${1}" >/dev/null
}


### BEGIN: "Command not found" handler

if rindeal:func_exists command_not_found_handle
then
	# portage registers a cnf handler for the `depend` phase
	# https://github.com/gentoo/portage/commit/40da7ee19c4c195da35083bf2d2fcbd852ad3846
	if [[ "${EBUILD_PHASE}" != 'depend' ]]
	then
		eqawarn "${ECLASS}.eclass: command_not_found_handle() already registered"
	fi
else

command_not_found_handle() {
	debug-print-function "${FUNCNAME[0]}" "${@}"
	local -r -- cmd="${1}"

	## do not die in a pipe
	[[ -t 1 ]] || return 127

	## do not die in a subshell
	local _pid _cmd _state _ppid _pgrp _session _tty_nr _tpgid _rest
	read _pid _cmd _state _ppid _pgrp _session _tty_nr _tpgid _rest < /proc/self/stat
	(( $$ == _tpgid )) && return 127

	die "'${cmd}': command not found"
}

fi

### END: "Command not found" handler


### BEGIN: Death hooks

rindeal:__death_hook() {
	eerror ""
	eerror "Ask for help at https://github.com/rindeal/rindeal-ebuild-repo/issues"
	eerror "instead of posting to https://forums.gentoo.org/ or worse https://bugs.gentoo.org/."
	eerror ""
}

if ! rindeal:has rindeal:__death_hook ${EBUILD_DEATH_HOOKS}
then
	EBUILD_DEATH_HOOKS+=" rindeal:__death_hook"
fi

### END: Death hooks


### BEGIN: hooking infrastructure

_rindeal:hooks:get_orig_prefix() {
	echo "__original_"
}

_rindeal:hooks:call_orig() {
	debug-print-function "${FUNCNAME[0]}" "${@}"

	local -r -- func="$(_rindeal:hooks:get_orig_prefix)${1}"

	if ! rindeal:func_exists "${func}"
	then
		die "${ECLASS}.eclass: ${FUNCNAME}: function '${func}' doesn't exist"
	fi

	"${func}" "${@:2}"
}

_rindeal:hooks:save() {
	debug-print-function "${FUNCNAME[0]}" "${@}"

	(( $# != 1 )) && die

	local -r -- name="${1}"
	local -r -- orig_prefix="$(_rindeal:hooks:get_orig_prefix)"

	# make sure we don't create an infinite loop
	if ! rindeal:func_exists "${orig_prefix}${name}"
	then

		# save original implementation under a different name
		eval "${orig_prefix}$(declare -f "${name}")"
	fi
}

### END: hooking infrastructure


### BEGIN: inherit hook

_rindeal:hooks:save inherit

## "static" assoc array
if [[ -z "$(declare -p _RINDEAL_ECLASS_SWAPS 2>/dev/null)" ]]
then
declare -g -A _RINDEAL_ECLASS_SWAPS=(
	['flag-o-matic']='flag-o-matic-patched'
	['ninja-utils']='ninja-utils-patched'
	['versionator']='versionator-patched'
	['vala']='vala-patched'
)
fi

inherit() {
	local -a new_args=( )

	local -- old_eclass
	for old_eclass in "${@}"
	do
		if [[ -v _RINDEAL_ECLASS_SWAPS["${old_eclass}"] ]]
		then
			local new_eclass="${_RINDEAL_ECLASS_SWAPS["${old_eclass}"]}"

			debug-print "${ECLASS}.eclass, ${FUNCNAME[0]}(): swapping '${old_eclass}' for '${new_eclass}"

			if [[ -n "${new_eclass}" ]]
			then
				new_args+=( "${new_eclass}" )
			fi

			# prevent infinite loops
			unset "_RINDEAL_ECLASS_SWAPS[${old_eclass}]"
		else
			new_args+=( "${old_eclass}" )
		fi
	done

	if (( ${#new_args[@]} ))
	then
		_rindeal:hooks:call_orig inherit "${new_args[@]}"
	else
		debug-print "${ECLASS}.eclass, ${FUNCNAME[0]}(): skipping orig call since all its arguments were erased"
	fi
}

### END: inherit hook


### BEGIN: standard tool wrappers

# `NO_V` env var implementation for use in standard tool wrappers
_NO_V() {
	(( NO_V )) || printf -- "--verbose"
}

rpushd() {
	pushd "${@}" >/dev/null || die -n
}

rpopd() {
	popd "${@}" >/dev/null || die -n
}

rmkdir() {
	mkdir $(_NO_V) --parents "${@}" || die -n
}

rcp() {
	cp $(_NO_V) "${@}" || die -n
}

rmv() {
	mv $(_NO_V) "${@}" || die -n
}

rln() {
	ln $(_NO_V) "${@}" || die -n
}

rchown() {
	chown $(_NO_V) "${@}" || die -n
}

rchmod() {
	chmod $(_NO_V) "${@}" || die -n
}

rrm() {
	rm $(_NO_V) --interactive=never --preserve-root --one-file-system "${@}" || die -n
}

rrmdir() {
	rmdir $(_NO_V) "${@}" || die -n
}

rsed() {
	if (( RINDEAL_DEBUG ))
	then
		local -a diff_prog=( diff -u )
		if command -v colordiff >/dev/null
		then
			diff_prog=( colordiff -u )
		fi

		local -A file_list
		local -a pretty_sed
		local -i i record_files=0
		for (( i = 1 ; i <= $# ; i ++ ))
		do
			local arg="${!i}"
			if (( record_files ))
			then
				file_list+=( ["${arg}"]="${RANDOM}${RANDOM}${RANDOM}" )
			else
				if [[ "${arg}" == "--" ]]
				then
					record_files=1
				else
					pretty_sed+=( "'${arg}'" )
				fi
			fi
		done

		(( ${#file_list[*]} )) || die -n

		local temp_dir="$(mktemp -d || die -n)"

		## backup original versions
		local -- f
		for f in "${!file_list[@]}"
		do
			cp -- "${f}" "${temp_dir}/${file_list["${f}"]}" || die -n
		done
	fi

	sed "${@}" || die -n

	if (( RINDEAL_DEBUG ))
	then
		local f
		for f in "${!file_list[@]}"
		do
			echo "*** diff of '${f}'"
			echo "*** for sed ${pretty_sed[*]}:"
			"${diff_prog[@]}" "${temp_dir}/${file_list["${f}"]}" "${f}"
			local code=$?
			(( code == 2 )) && die -n
			(( code == 0 )) && eqawarn "sed didn't change anything"
		done
		rm -r -- "${temp_dir}" || die -n
	fi
}

# Usage: rdosym <target> <linkpath> [<linkpath>...]
rdosym() {
	local -i _rel_arg=0

	while (( ${#} ))
	do
		case "${1}" in
			--rel ) _rel_arg=1 ;;
			-- )
				(( ${#} < 2 )) && die "Not enough arguments given"

				shift # consume double dash

				local -r -- _target_arg="${1}"
				shift

				local -r -a _linkpath_args=( "${@}" )
				break
				;;
			* ) die "Unknown argument '${1}'" ;;
		esac
		shift
	done

	local -- _target="${_target_arg}"

	local -- _linkpath
	for _linkpath in "${_linkpath_args[@]}"
	do
		local -- _target="${_target_arg}"

		if (( _rel_arg ))
		then
			local -- _linkpath_dir="$(dirname "${_linkpath}" || die)"
			local -a realpath_cmd=( realpath
				--canonicalize-missing
				--no-symlinks
				--relative-to="${_linkpath_dir}"
				"${_target}"
			)
			_target="$("${realpath_cmd[@]}" || die)"
		fi

		echo "dosym: '${_linkpath}' -> '${_target}' ('${_target_arg}')"
		dosym "${_target}" "${_linkpath}"
	done
}

### END: standard tool wrappers

yesno()
{
	(( ${#} != 1 )) && die
	local -r -- input_arg="${1}"

	local -- input="${input_arg}"

	## strip whitespace around input string
	while [[ "${input}" == [[:space:]]* ]]
	do
		input="${input#[[:space:]]}"
	done
	while [[ "${input}" == *[[:space:]] ]]
	do
		input="${input%[[:space:]]}"
	done

	case "${input}" in
	[Yy][Ee][Ss] | [Tt][Rr][Uu][Ee]     | [Oo][Nn]     | 1 ) return 0  ;;
	[Nn][Oo]     | [Ff][Aa][Ll][Ss][Ee] | [Oo][Ff][Ff] | 0 ) return -1 ;;
	* )
		debug-print "${FUNCNAME[0]}: no match for '${1}'"
		return -1
		;;
	esac
}

# this function can be used for a first line in files generated by the ebuild logic
print_generated_file_header() {
	printf "Automatically generated by %s/%s on %s\n" "${CATEGORY}" "${PF}" "$(date --utc --iso-8601=minutes)"
}


_RINDEAL_ECLASS=1
fi
