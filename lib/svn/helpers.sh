export SVN_BINARY=$(find_binary svn)

function fail_if_not_svn_repo() {
  if ! find_in_cwd_or_parent ".svn" > /dev/null; then
    echo -e "\033[31mNot a svn repository (or any of the parent directories)\033[0m"
    return 1
  fi
  return 0
}
