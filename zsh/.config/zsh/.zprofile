if [ "$(tty)" = "/dev/tty1" -a -z "$DISPLAY" ]; then
    # Display login prompt
    OK="0"

    while [ "$OK" != "1" ]; do
        printf "\nOptions: sx, nvidia-xrun/nvidia, tty/sh\n> "
        read SELECTION

        case "$SELECTION" in
            "sx") exec sx ;;

            "nvidia-xrun"|"nvidia") exec nvidia-xrun ;;

            "tty"|"sh") OK="1"
                        break
                        ;;

            *) OK="0"
               printf "\nPlese enter a valid option.\n"
               ;;
        esac
    done
fi
