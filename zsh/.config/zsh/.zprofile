S6_RC_LIVE_DIR="/tmp/s6-rc-${UID}"

if ! [ -e "/tmp/.$(id -u)-zprofile-once" ]; then
    touch "/tmp/.$(id -u)-zprofile-once"

    # Wayland disallow binding wayland-0
    if ! [ -e "/run/user/${UID}/wayland-0" ]; then
        touch "/run/user/${UID}/wayland-0"
        chmod 0000 "/run/user/${UID}/wayland-0"
    fi
    if ! [ -e "/run/user/${UID}/wayland-0.lock" ]; then
        touch "/run/user/${UID}/wayland-0.lock"
        chmod 0000 "/run/user/${UID}/wayland-0.lock"
    fi

    if [ -L "${S6_RC_LIVE_DIR}" ]; then
        # Make sure default bundle is up
        s6-rc -l "${S6_RC_LIVE_DIR}" -u change default
    fi

    [ -f /mnt/tmp/.bashrc ]  || cp --dereference ~/.bashrc /mnt/tmp/
    [ -f /mnt/tmp/.inputrc ] || cp --dereference ~/.inputrc /mnt/tmp/
fi

xhost +si:localuser:root >/dev/null 2>&1

#if tty | grep -E '^/dev/tty[0-9]+$' >/dev/null 2>&1 && [ -z "${DISPLAY}" ]; then
#    if [ -L "${S6_RC_LIVE_DIR}" ]; then
#        # Check if pipewire is running, if it isn't working, restart it
#        pidof pipewire >/dev/null 2>&1 && pw-cli info all >/dev/null 2<&1 || {
#            s6-rc -l "${S6_RC_LIVE_DIR}" -db change pipewire-all
#            s6-rc -l "${S6_RC_LIVE_DIR}" -ub change pipewire-all
#        }
#    fi
#fi

if [ "$(tty)" = "/dev/tty1" -a -z "$DISPLAY" ]; then
    # Display login prompt
    OK="0"

    while [ "$OK" != "1" ]; do
        printf "\nOptions: sway (w), tty/sh\n> "
        read SELECTION

        case "$SELECTION" in
            "w"|"sway")
                # NOTE: Only use iGPU
                exec env WLR_DRM_DEVICES="$(realpath /dev/dri/by-path/pci-0000:05:00.0-card)" /usr/bin/sway
                ;;

            "tty"|"sh"|"t")
                OK="1"
                break
                ;;

            "arcan"|"a")
                exec arcan durden
                ;;

            *)
                OK="0"
                printf "\nPlese enter a valid option.\n"
                ;;
        esac
    done
fi
