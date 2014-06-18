svn_status_shortcuts() {
    fail_if_not_svn_repo || return 1

    local counter=1

    local -a split
    local -A header
    local mode filename message color spacer oldstatus=""

    header=("A" "Changes to be commited:")
    header+=("C" "Conflicted changes:")
    header+=("D" "Deleted files:")
    header+=("I" "Ignored files:")
    header+=("M" "Modified files:")
    header+=("?" "Untracked files:")

    typeset -r header

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

	if [[ $oldstatus != $mode ]]; then
	    oldstatus=$mode
	    echo ""
	    echo "➤ $header[$mode]"
	    echo "$color#\033[0m"
	fi

	if [[ $counter -lt 10 ]]; then
	    spacer=" "
	else
	    spacer=""
	fi
	echo -e "$color#\t$message $spacer\033[0m[\033[2;37m$counter\033[0m $color$filename\033[0m"
	export r$counter="$filename"
	((counter++))
    done
}
