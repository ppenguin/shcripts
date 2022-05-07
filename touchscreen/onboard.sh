#!/usr/bin/env bash

if pgrep -f onboard | xargs kill -0 2>/dev/null; then
	dbus-send --type=method_call `#--print-reply` \
		--dest=org.onboard.Onboard \
		/org/onboard/Onboard/Keyboard \
		org.onboard.Onboard.Keyboard.ToggleVisible
else
	onboard &
fi

