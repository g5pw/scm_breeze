# ------------------------------------------------------------------------------
# SCM Breeze - Streamline your SCM workflow.
# Copyright 2011 Nathan Broadbent (http://madebynathan.com). All Rights Reserved.
# Copyright 2014 Aljaž Srebrnič. All Rights Reserved.
# Released under the LGPL (GNU Lesser General Public License)
# ------------------------------------------------------------------------------

# Set up configured aliases & keyboard shortcuts
# --------------------------------------------------------------------
# _alias() ignores errors if alias is not defined. (from lib/scm_breeze.sh)

_alias svn_aliases="list_aliases svn"

# Remove any existing svn alias or function
unalias svn > /dev/null 2>&1
unset -f svn > /dev/null 2>&1

# Define svn alias with tab completion
# Usage: __svn_alias <alias> <command_prefix> <command>
__svn_alias () {
  if [ -n "$1" ]; then
    local alias_str="$1"; local cmd_prefix="$2"; local cmd="$3"; local cmd_args="${4-}"
    alias $alias_str="$cmd_prefix $cmd${cmd_args:+ }$cmd_args"
    if [ "$shell" = "bash" ]; then
      __define_svn_completion $alias_str $cmd
      complete -o default -o nospace -F _svn_"$alias_str"_shortcut $alias_str
    fi
  fi
}
# --------------------------------------------------------------------
# SCM Breeze functions
_alias $svn_status_shortcuts_alias="svn_status_shortcuts"
_alias $svn_add_shortcuts_alias="svn_add_shortcuts"

# Only set up the following aliases if 'svn_setup_aliases' is 'yes'
if [ "$svn_setup_aliases" = "yes" ]; then
  # Commands that deal with paths
  __svn_alias "$svn_checkout_alias"    "svn" "checkout"
  __svn_alias "$svn_commit_alias"      "svn" "commit"
  __svn_alias "$svn_blame_alias"       "svn" "blame"
  __svn_alias "$svn_diff_alias"        "svn" "diff"
  __svn_alias "$svn_add_alias"         "svn" "add"

  # Standard commands
  __svn_alias "$svn_status_original_alias" "svn" 'status' # (Standard svn status)
  __svn_alias "$svn_cleanup_alias" "svn" "cleanup"
  __svn_alias "$svn_merge_alias" "svn" 'merge'
  __svn_alias "$svn_log_alias" "svn" "log"
fi
