#    This file is part of init-tmux.
#
#    init-tmux is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    init-tmux is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with init-tmux.  If not, see <http://www.gnu.org/licenses/>.


# Session file suffixes
SESSION_SFX="session"
SHELL_SFX="shell"

# Name of Tmux session file directory
TMUX_D="tmux.d"

#function to display pretty messages
function message()
{
  #Assume $1 is message type & $2 is message
  #See http://www.frexx.de/xterm-256-notes/ for information on xterm colour codes
    case "$1" in
      error)
        #use escape sequence to show red text
        echo -e "\033[31m${2}\033[0m" 1>&2
      ;;
      ok)
        #use escape sequence to show green text
        echo -e "\033[32m${2}\033[0m"
      ;;
      nnl)
        #use echo -n to avoid new line
        echo -n "$2"
        ;;
      info)
        echo "$2"
        ;;
      *)
        echo "$2"
    esac
}

# function to load session names
# INIT_TMUX_SESSION_DIR must be set to the session directory.
# This sets an indexed array named SESSIONS containing session names.
# The Caller must do ``declare -a SESSIONS`` before calling this function
function getSessionNames()
{
    if [ ! -e "${INIT_TMUX_SESSION_DIR}" ]; then
        message error "${INIT_TMUX_SESSION_DIR} does not exist"
        exit 1
    fi

    cd "${INIT_TMUX_SESSION_DIR}"

    COUNTER=0
    for session in $(cd ${INIT_TMUX_SESSION_DIR} && find -iname '*.'${SESSION_SFX} ); do
        SESSIONS[${COUNTER}]=$(echo "${session}" | sed 's#^./\(.\+\)\.session$#\1#')
        COUNTER=$((++COUNTER))
    done
}
