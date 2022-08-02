if [ "$(tty)" = "/dev/tty1" -a -z "$DISPLAY" ]; then
    # Display login prompt
    OK="0"

    while [ "$OK" != "1" ]; do
        printf "\nOptions: sx, nvidia-xrun/nvidia, tty/sh\n> "
        read SELECTION

        case "$SELECTION" in
            "sx"|"x") exec sx ;;

            "nvidia-xrun"|"nvidia"|"n") exec nvidia-xrun ;;

            "river"|"r"|"w") exec river ;;

            "tty"|"sh"|"t") OK="1"
                        break
                        ;;

            *) OK="0"
               printf "\nPlese enter a valid option.\n"
               ;;
        esac
    done
fi
