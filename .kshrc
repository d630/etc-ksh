#!/usr/bin/env ksh
#
# Sourced via ENV

[[ $- == *i* ]] ||
    return 1;

((SHLVL++));

if
    (($(id -u)));
then
    PS1='% ';
else
    PS1='# ';
fi;

PS2='> ';

HOSTNAME=$(hostname -s 2>/dev/null);
[[ "$HOSTNAME" == *([	 ]|localhost) ]] &&
    HOSTNAME=$(hostname 2>/dev/null);
export HOSTNAME;

export SHELL=$(whence -p ksh);
export HISTFILE=${XDG_VAR_HOME}/spool/ksh_history;
export HISTSIZE=10000;

stty -ixon -ctlecho;
tabs -4;

set -o emacs;

function up {
    if
        [[ -z ${1//[0-9]/} ]];
    then
        typeset s=$(printf '%*s' ${1:-1} '');
        command cd -- ${s// /../} &&
            print "cd -- $PWD";
    else
        print "Usage: up [<INT>]" 1>&2;
        return 1;
    fi;
};

. "$HOME/.profile.d/ext.sh";
. "$HOME/.profile.d/base.sh";
. "$HOME/.profile.d/run.sh";

\ProfileRcBaseAlias;

[[ $- == *l* ]] && {
	alias 'autoload=typeset -fu'
	alias 'bool=_Bool'
	alias 'command=command  '
	alias 'compound=typeset -C'
	alias 'fc=hist'
	alias 'float=typeset -lE'
	alias 'functions=typeset -f'
	alias 'hash=alias -t --'
	alias 'history=hist -l'
	alias 'integer=typeset -li'
	alias 'nameref=typeset -n'
	alias 'nohup=nohup  '
	alias 'r=hist -s'
	alias 'redirect=command exec'
	alias 'source=command .'
	alias 'stop=kill -s STOP'
	alias 'suspend=kill -s STOP "$$"'
	alias 'type=whence -v'
}

\ProfileRcRunGpg 1>/dev/null;
\ProfileRcRunKeychainInteractiv;
\ProfileRcRunLsSet;

# vim: set ft=sh :
