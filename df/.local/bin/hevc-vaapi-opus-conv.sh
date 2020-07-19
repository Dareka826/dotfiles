#!/bin/sh

# Transcode video with vaapi
ffmpeg -vaapi_device /dev/dri/renderD128 -i $1 -vf 'format=nv12,hwupload' -c:v hevc_vaapi -rc_mode CQP -qp 26 -an /tmp/v.mp4
# Transcode audio and join with transcoded video
ffmpeg -vn -i $1 -i /tmp/v.mp4 -c:v copy -c:a libopus -b:a 128k -f matroska $1-conv.mkv
# Remove temporary transcoded video
rm /tmp/v.mp4
