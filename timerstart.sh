sleep 0.5
modtwo=0
zfill() {
    local len=$1
    local str=$2
    printf "%0${len}d" "$str"
}


while true; do
    timer_start=$(($(grep -o 'start:.*' timer_data | cut -d ' ' -f 2-)+0))
    timer_stop=$(($(grep -o 'stop:.*' timer_data | cut -d ' ' -f 2-)+0))

    BAT="$(acpi | awk '{print $4}' | tr -d '%,')%";
    WIFI="$(iwgetid -r)";
    DATE="$(date +'%m.%d. (%a) %H:%M')";

    current_time=$(date +%s)
    time_remaining=$((timer_stop - current_time))
    timer_length=$((timer_stop - timer_start))
    timer_min=$((time_remaining/ 60))
    #TIMER=$(printf %b '\u2588')
    if [ "$timer_min" -lt -1 ]; then
        timer_min="__"
    elif [ "$timer_min" -lt 0 ]; then
        modtwo=$((modtwo+1))
        modtwo=$((modtwo%2))
        if (( modtwo==0 )); then
            timer_min="  "
            spd-say 'p'
        else
            timer_min="##"
        fi
    fi

    timer_min=$(zfill 2 $timer_min)
    DWMSTATUS="${timer_min} [${WIFI}] ${BAT} ${DATE}";
    xsetroot -name "$DWMSTATUS";

    sleep .5
done &

    xsetroot -name "$DWMSTATUS";

    sleep .5
done &
