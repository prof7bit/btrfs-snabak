_btrfs-snabak()
{
    local cur prev commands confdir configs
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="snapshot backup list"
    confdir=/etc/btrfs-snabak/configs
    configs=$(for file in "$confdir"/*; do echo "${file##*/}" ; done )

    # previous word was a command or a config (may enter multiple configs)
    if [[ "$commands $configs" =~ $prev ]]; then
      COMPREPLY=($(compgen -W "$configs" -- "${cur}"))

    elif [[ "btrfs-snabak" == "$prev" ]]; then
      COMPREPLY=($(compgen -W "$commands" -- "${cur}"))

    fi
    return 0
}
complete -F _btrfs-snabak btrfs-snabak
