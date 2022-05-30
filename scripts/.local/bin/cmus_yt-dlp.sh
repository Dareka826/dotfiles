#!/bin/sh

OUTDIR="$HOME/.config/cmus/yt-tracks"
install -d -o "${USER}" -g "${USER}" -m 0755 "${OUTDIR}"

for ID in "$@"; do
    # Download file if doesn't exist
    if [ "$(find "${OUTDIR}" -name "${ID}.*")" = "" ]; then
        yt-dlp --no-mtime \
            -x --id \
            -f 'bestaudio[acodec=opus]/best[acodec=opus]/bestaudio/best' \
            --add-metadata \
            -P "${OUTDIR}" \
                ${ID}
    fi

    # Find file name
    ID_FNAME="$(find "${OUTDIR}" -name "${ID}.*")"

    # If file extension isn't opus, convert
    F_EXT="$(printf "%s\n" "${ID_FNAME}" | sed 's/^.*\.//')"
    if [ "${F_EXT}" != "opus" ]; then
        OLD_FNAME="${ID_FNAME}"
        ID_FNAME="$(printf "%s\n" "${ID_FNAME}" | sed 's/\.[^.]*$/\.opus/')"

        ffmpeg -i "${OLD_FNAME}" -c:a libopus -b:a 128k "${ID_FNAME}" \
            && rm -f "${OLD_FNAME}"
    fi

    # Calculate gain if gainless
    ffprobe "${ID_FNAME}" 2>&1 | grep 'R128_TRACK_GAIN' >/dev/null \
        || loudgain -k -s e "${ID_FNAME}"

    opusinfo "${ID_FNAME}" 2>&1 | grep '^	Playback gain: 0 dB' \
        && ~/repos/zoog/target/release/zoog --prioritize track "${ID_FNAME}"

    # Add the track to cmus
    cmus-remote -C "add ${ID_FNAME}"
done
