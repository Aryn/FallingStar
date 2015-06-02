/obj/station/door/var/is_animating = 0
/obj/station/door/var/is_open = 0

/obj/station/door/proc/_CanOpen(mob/user)
	return !is_animating
/obj/station/door/proc/_CanClose(mob/user)
	return !is_animating

/obj/station/door/proc/_Open()
/obj/station/door/proc/_Close()

/obj/station/door/proc/_TryOpen(mob/user)
	if(src._CanOpen(user))
		spawn src._Open()
		return 1
	return 0

/obj/station/door/proc/_TryClose(mob/user)
	if(src._CanClose(user))
		spawn src._Close()
		return 1
	return 0

/obj/station/door/Operated(mob/user)
	if(is_open)
		_TryClose(user)
	else
		_TryOpen(user)