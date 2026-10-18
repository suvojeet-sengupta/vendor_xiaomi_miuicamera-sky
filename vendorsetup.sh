#!/bin/bash

miuicamera_merge_apk() {
    local dir="${T:-$(gettop)}/vendor/xiaomi/miuicamera-sky/proprietary/system/priv-app/MiuiCamera"
    [ -f "$dir/MiuiCamera.apk" ] && [ "$dir/MiuiCamera.apk" -nt "$dir/MiuiCamera.apk.hash" ] && return

    if (cd "$dir" && sha256sum --quiet -c MiuiCamera.apk.hash && cat MiuiCamera.apk.part* > MiuiCamera.apk.tmp && mv MiuiCamera.apk.tmp MiuiCamera.apk); then
        echo "miuicamera-sky: merged MiuiCamera.apk" >&2
    else
        rm -f "$dir/MiuiCamera.apk.tmp"
        echo "miuicamera-sky: MiuiCamera.apk parts are corrupt, resync vendor/xiaomi/miuicamera-sky" >&2
    fi
}

miuicamera_merge_apk
unset -f miuicamera_merge_apk
