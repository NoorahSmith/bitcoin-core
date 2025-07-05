# bash programmable completion for smithcoind(1) and smithcoin-qt(1)
# Copyright (c) 2012-2022 The Smithcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

_smithcoind() {
    local cur prev words=() cword
    local smithcoind

    # save and use original argument to invoke smithcoind for -help
    # it might not be in $PATH
    smithcoind="$1"

    COMPREPLY=()
    _get_comp_words_by_ref -n = cur prev words cword

    case "$cur" in
        -conf=*|-pid=*|-loadblock=*|-rpccookiefile=*|-wallet=*)
            cur="${cur#*=}"
            _filedir
            return 0
            ;;
        -datadir=*)
            cur="${cur#*=}"
            _filedir -d
            return 0
            ;;
        -*=*)	# prevent nonsense completions
            return 0
            ;;
        *)

            # only parse -help if sensible
            if [[ -z "$cur" || "$cur" =~ ^- ]]; then
                local helpopts
                helpopts=$($smithcoind -help 2>&1 | awk '$1 ~ /^-/ { sub(/=.*/, "="); print $1 }' )
                COMPREPLY=( $( compgen -W "$helpopts" -- "$cur" ) )
            fi

            # Prevent space if an argument is desired
            if [[ $COMPREPLY == *= ]]; then
                compopt -o nospace
            fi
            return 0
            ;;
    esac
} &&
complete -F _smithcoind smithcoind smithcoin-qt

# Local variables:
# mode: shell-script
# sh-basic-offset: 4
# sh-indent-comment: t
# indent-tabs-mode: nil
# End:
# ex: ts=4 sw=4 et filetype=sh
