/obj/station/door/airlock/icon = 'Icons/Objects/Station/Doors/Airlock.dmi'
/obj/station/door/airlock/icon_state = "door_closed"
/obj/station/door/airlock/density = 1
/obj/station/door/airlock/opacity = 1
/obj/station/door/airlock/airtight = 1

/obj/station/door/airlock/Bumped(atom/movable/bumper)
	if(src._TryOpen(bumper))
		sleep(20)
		src._TryClose(bumper)

/obj/station/door/airlock/_Open()
	is_animating = 1
	icon_state = "door_open"
	flick("door_opening",src)
	airtight = 0
	sleep(3)
	opacity = 0
	sleep(3)
	density = 0
	is_animating = 0
	is_open = 1

/obj/station/door/airlock/_Close()
	is_animating = 1
	icon_state = "door_closed"
	flick("door_closing",src)
	density = 1
	sleep(3)
	opacity = 1
	sleep(3)
	airtight = 1
	is_animating = 0
	is_open = 0
