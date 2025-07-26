#!/usr/bin/env bash

# Define functions
print_error() {
  cat <<"EOF"
Usage: ./volumecontrol.sh -[device] <actions>
...valid devices are...
    i   -- input device
    o   -- output device
    p   -- player application
...valid actions are...
    i   -- increase volume [+2]
    d   -- decrease volume [-2]
    m   -- mute [x]
EOF
  exit 1
}

get_vol()  { wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk 'NR==1{print int($2*100)}'; }
get_mute() {
	wpctl status | awk '/Sinks:/,/Sources:/' \
		| grep -E '^[^0-9]*\*\s*[0-9]+\.' \
		| grep -q 'MUTED' \
		&& echo true \
		|| echo false;
}


icon() {
  vol=$(get_vol)
  mute=$(get_mute)

  if [ "$mute" = "true" ] || [ "$vol" -eq 0 ]; then
    icon="volume-level-muted"
  elif [ "$vol" -lt 33 ]; then
    icon="volume-level-low"
  elif [ "$vol" -lt 66 ]; then
    icon="volume-level-medium"
  else
    icon="volume-level-high"
  fi
}

send_notification() {
	icon
	mute=$(get_mute)        
	if [ "$mute" = "true" ]; then
		notify-send                               \
			--app-name="volume"                     \
			--replace-id=91190                      \
			--hint=int:value:0                   \
			--hint=string:x-dunst-stack-tag:volume  \
			-i "$icon" "Muted";
	else
		notify-send                               \
			--app-name="volume"                     \
			--replace-id=91190                      \
			--hint=int:value:$vol                   \
			--hint=string:x-dunst-stack-tag:volume  \
			-i "$icon" "Volume";
	fi
}

notify_mute() {
	icon                  # refresh $icon for the current vol
	mute=$(get_mute)        # ← use the helper

	if [ "$mute" = "true" ]; then
		notify-send                               \
			--app-name="volume"                     \
			--replace-id=91190                      \
			--hint=int:value:0                   \
			--hint=string:x-dunst-stack-tag:volume  \
			-i "$icon" "Muted"
	else
		notify-send                               \
			--app-name="volume"                     \
			--replace-id=91190                      \
			--hint=int:value:$vol                   \
			--hint=string:x-dunst-stack-tag:volume  \
			-i "$icon" "Volume"
	fi
}


action_volume() {
  current_vol=$(get_vol)
  case $1 in
    i) new=$(( current_vol + 2 )); [ $new -gt 100 ] && new=100 ;;
    d) new=$(( current_vol - 2 )); [ $new -lt   0 ] && new=0   ;;
  esac
  wpctl set-volume @DEFAULT_AUDIO_SINK@ "${new}%"
}

select_output() {
  if [ "$#" -gt 0 ]; then
    desc="$*"
    id=$(wpctl status | awk '/Sinks:/,/Sources:/' |
         grep -E '^[^0-9]*[0-9]+\.' |
         grep -F "$desc"         |
         sed -E 's/[^0-9]*([0-9]+)\..*/\1/')
    if [ -n "$id" ] && wpctl set-default "$id"; then
      notify-send -r 91190 "Activated: $desc"
    else
      notify-send -r 91190 "Error activating $desc"
    fi
  else
    wpctl status | awk '/Sinks:/,/Sources:/' |
      grep -E '^[^0-9]*[0-9]+\.'            |
      sed -E 's/^[^0-9]*[0-9]+\.\s*(.*)\[vol.*$/\1/' |
      sed 's/[[:space:]]*$//'
  fi
}

# Evaluate device option
while getopts iops: DeviceOpt; do
	case "${DeviceOpt}" in
		i)
			nsink=$(wpctl status | awk '/Sources:/,/Filters:/' | grep -E '^[^0-9]*[0-9]+\.' | wc -l)
			[ "$nsink" -eq 0 ] && echo "ERROR: Input device not found..." && exit 0
			srce="--default-source"
			;;
		o)
			nsink=$(wpctl status | awk '/Sinks:/,/Sources:/' | grep -E '^[^0-9]*[0-9]+\.' | wc -l)
			[ "$nsink" -eq 0 ] && echo "ERROR: Output device not found..." && exit 0
			srce=""
			;;
		p)
			nsink=$(playerctl --list-all | grep -w "${OPTARG}")
			[ -z "${nsink}" ] && echo "ERROR: Player ${OPTARG} not active..." && exit 0
			srce="${nsink}"
			;;
		s)
			select_output "$@"
			exit
			;;
		*) print_error ;;
	esac
done

# Set default variables
shift $((OPTIND - 1))

# Execute action
case "${1}" in
	i) action_volume i ;;
	d) action_volume d ;;
	m) wpctl set-mute @DEFAULT_SINK@ toggle && notify_mute && exit 0 ;;
	*) print_error ;;
esac

send_notification
