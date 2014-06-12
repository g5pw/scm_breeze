svn_status_shortcuts() {
    fail_if_not_svn_repo || return 1

    local counter=1

    local -a split
    local mode filename message color


    $SVN_BINARY status | sort -r | while read line; do
	split=("${(s< >)line}")
	mode=$split[1]
	filename=$split[2,-1]

	color="\033[0;"

	case $mode in
	    'A' )
		color+="33m"
		message="     added:"
		;;
	    'C' )
		color+="31m"
		message="conflicted:"
		;;
	    'D' )
		color+="31m"
		message="   deleted:"
		;;
	    'I' )
		color="\033[2;37m"
		message="   ignored:"
		;;
	    'M' )
		color+="32m"
		message="  modified:"
		;;
	    'R' )
		color+="34m"
		message="  replaced:"
		;;
	    '!' )
		color+="31m"
		message="   missing:"
		;;
	    '?' )
		color+="36m"
		message=" untracked:"
		;;
	    * )
		color+="0m"
		message="    unknown:"
	esac
	echo -e "\t$color$message \033[0m[\033[2;37m$counter\033[0m] $color$filename\033[0m"
	export r$counter="$filename"
	((counter++))
    done
}
