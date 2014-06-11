export GIT_BINARY=$(find_binary git)

function fail_if_not_git_repo() {
  if ! find_in_cwd_or_parent ".git" > /dev/null; then
    echo -e "\033[31mNot a git repository (or any of the parent directories)\033[0m"
    return 1
  fi
  return 0
}