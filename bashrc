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

# This script initialises the environment

# Load normal user's bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

# Switch to init-tmux's root directory
OLD_PWD="$(pwd)"
cd "${BASH_SOURCE[0]%/*}"

source utils.sh

# Get session that we want to load script for.
#
# We are relying on the fact that the most recently
# used session is the session used.
TMUX_SESSION_NAME=$(tmux display -p '#S')

if [ -z "${TMUX_SESSION_NAME}" ]; then
    message error "Could not determine session name. Not loading configuration."
else
    cd "${TMUX_D}"
    INIT_SHELL_SCRIPT="${TMUX_SESSION_NAME}.${SHELL_SFX}"

    if [ ! -e "${INIT_SHELL_SCRIPT}" ]; then
        message error "Could not load session script '${INIT_SHELL_SCRIPT}'"
    else
        # We can now load the session script
        source "${INIT_SHELL_SCRIPT}" &&  message ok "Loaded ${INIT_SHELL_SCRIPT}"
    fi
fi

# Go back to our original directory
cd "${OLD_PWD}"

# Try to uncluter the shell environment
unset SESSIONS TMUX_SESSION_NAME SESSION_SCRIPT OLD_PWD
unset SESSION_SFX SHELL_SFX TMUX_D
unset message getSessionNames
