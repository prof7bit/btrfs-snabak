_btrfs-snabak()
{
    local cur prev prev2
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    prev2="${COMP_WORDS[COMP_CWORD-2]}"
    words=$(btrfs-snabak compassist "$prev" "$prev2")
    COMPREPLY=( $(compgen -W "$words" -- "$cur") )
    return 0
}
complete -F _btrfs-snabak btrfs-snabak
