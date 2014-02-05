Init-tmux
=========

This is a small set of scripts that automates the starting and stopping multiple
Tmux sessions (bash shells) each with a different configuration.

To see the usage information run

```
$ init-tmux
```

Configuration
=============

When ``init-tmux`` is used it will look for session files in ``tmux.d/``.

Each session needs two files ``YOUR_SESSION_NAME.session`` and ``YOUR_SESSION_NAME.shell``
where ``YOUR_SESSION_NAME`` is the name your want for your session. 

``init-tmux`` will create a Tmux session for every ``*.session`` file in ``tmux.d/``.

YOUR_SESSION_NAME.session
-------------------------

This file is treated as a bash script and is executed by the the ``init-tmux`` command when
the session is first created (it is not run in the session's shells).
This is typically used to configure the session. A shell variable ``${INIT_TMUX_SESSION}``
is available in this script which is the name of the session being initialised.

See ``tmux.d/example1.session`` for an example.


YOUR_SESSION_NAME.shell
-----------------------

This file is treated as a bash script and is executed everytime a shell is created inside
the tmux session. This is typically used to setup up environment variables (e.g. PATH).

See ``tmux.d/example1.shell`` for an example.

Typical usage
=============

```
$ init-tmux start
$ init-tmux status

# Using init-tmux's interactive prompt to attach to a session
# An alternative is running tmux attach-session -t YOUR_SESSION_NAME
$ init-tmux attach
# Detach...

$ init-tmux stop
```
