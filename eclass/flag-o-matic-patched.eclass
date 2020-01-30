# Copyright 2016-2017 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: flag-o-matic-patched.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: <SHORT_DESCRIPTION>
# @DESCRIPTION:

case "${EAPI:-0}" in
6 | 7 ) ;;
* ) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


inherit flag-o-matic


# @FUNCTION: get-flag
# @USAGE: <flag>
# @DESCRIPTION:
# Find and echo the value for a particular flag.  Accepts shell globs.
#
# Example:
# @CODE
# CFLAGS="-march=i686 -O1"
# get-flag -march # outputs "-march=i686"
# get-flag march  # outputs "i686"
# get-flag '-O*'  # outputs "-O1"
# @CODE
# ORIGIN: flag-o-matic
# PR: https://github.com/gentoo/gentoo/pull/1425
get-flag() {
	local pattern="${1}"
	# ensure ${needle} starts with a single dash
	local needle="-${pattern#-}"

	local var
	for var in $(all-flag-vars) ; do
		local i flags=( ${!var} )

		# reverse loop because last flag wins
		for (( i = ${#flags[@]} - 1 ; i >= 0 ; i-- )) ; do
			local flag="${flags[i]}"
			# strip value as it's not needed for comparison
			local haystack="${flag%%=*}"

			# as long as ${needle} remains unquoted, wildcards will work
			if [[ "${haystack}" == ${needle} ]] ; then
				# preserve only value if only flag name was provided
				local ret="${flag#-${pattern}=}"

				# ${ret} might contain `-e` or `-n` which confuses echo
				printf '%s\n' "${ret}"

				return 0
			fi
		done
	done

	return 1
}
