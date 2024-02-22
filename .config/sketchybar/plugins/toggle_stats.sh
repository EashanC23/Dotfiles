#!/usr/bin/env bash

hide_stats() {
	sketchybar		--set cpu_percent								\
		label.drawing=off \
		icon.drawing=off  \
		--set cpu_label												\
		label.drawing=off	\
		icon.drawing=ooff		\
		--set ram_label												\
		label.drawing=off \
		icon.drawing=off  \
		--set ram_percentage												\
		label.drawing=off	\
		icon.drawing=ooff		\
		--set stats_separator							\
		icon=


	}

	show_stats() {
		sketchybar	--set cpu_label									\
			label.drawing=on	\
			icon.drawing=on		\
			--set cpu_percent                                           \
			label.drawing=on	\
			icon.drawing=on		\
			--set ram_label												\
			label.drawing=on	\
			icon.drawing=on		\
			--set ram_percentage												\
			label.drawing=on	\
			icon.drawing=on		\
			--set stats_separator							\
			icon=
		}

		toggle_stats() {
			state=$(sketchybar --query stats_separator | jq -r .icon.value)
			case $state in
				"") show_stats
					;;
				"") hide_stats
					;;
			esac
		}

		case "$SENDER" in
			"hide_stats") hide_stats
				;;
			"show_stats") show_stats
				;;
			"toggle_stats") toggle_stats
				;;
		esac
