function e_header()  { echo -e "\n\033[1m$@\033[0m"; }
function e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()   { echo -e " \033[1;33m➜\033[0m  $@"; }

# Given a list of desired items and installed items, return a list
# of uninstalled items. Arrays in bash are insane (not in a good way).
function to_install() {
    local debug desired installed i desired_s installed_s remain
    if [[ "$1" == 1 ]]; then debug=1; shift; fi
    # Convert args to arrays, handling both space- and newline-separated lists
    read -ra desired < <(echo "$1" | tr '\n' ' ')
    read -ra installed < <(echo "$2" | tr '\n' ' ')
    # Sort desired and installed arrays
    unset i; while read -r; do desired_s[i++]=$REPLY; done < <(
        printf "%s\n" "${desired[@]}" | sort
    )
    unset i; while read -r; do installed_s[i++]=$REPLY; done < <(
        printf "%s\n" "${installed[@]}" | sort
    )
    # Get the difference. comm is awesome
    unset i; while read -r; do remain[i++]=$REPLY; done < <(
        comm -13 <(printf "%s\n" "${installed_s[@]}") <( printf "%s\n" "${desired_s[@]}")
    )
    [[ "$debug" ]] && for v in desired desired_s installed installed_s remain; do
        echo "$v ($(eval echo "\${#$v[*]}")) $(eval echo "\${$v[*]}")"
    done
    echo "${remain[@]}"
}

# Offer the user a chance to skip something
function skip() {
    REPLY=noskip
    read -t 5 -n 1 -s -p "To skip, press X within 5 seconds. "
    if [[ "$REPLY" =~ ^[Xx]$ ]]; then
        echo "Skipping!"
    else
        echo "Continuing..."
        return 1
    fi
}
