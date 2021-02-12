_btrfs-snabak()
{
    local cur prev prev2 words
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    prev2="${COMP_WORDS[COMP_CWORD-2]}"

    # The entire completion logic is implemented in
    # the tool itself: Given the two previous words
    # on the command line its subcommand "compassist"
    # will dump the list of possible completions.
    words=$(btrfs-snabak compassist "$prev" "$prev2")

    COMPREPLY=( $(compgen -W "$words" -- "$cur") )
    return 0
}
complete -F _btrfs-snabak btrfs-snabak
