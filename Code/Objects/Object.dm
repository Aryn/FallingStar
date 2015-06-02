//Substitute for del()
proc/Erase(datum/thing)
	thing.Erase()

/datum/proc/Erase()

/atom/movable/Erase()
	tag = null
	if(!Move(null)) loc = null

/atom/movable/Bump(atom/obstacle)
	obstacle.Bumped(src)

/atom/proc/Bumped(atom/movable/bumper)

/atom/proc/Operated(mob/user)
/atom/proc/OperatedAtRange(mob/user)

/atom/proc/Applied(mob/user, item/item)
/atom/proc/AppliedAtRange(mob/user, item/item)

/atom/Click()
	var/mob/user = usr
	if(get_dist(user, src) <= 1)
		if(user.active_slot.item)
			Applied(user, user.active_slot.item)
		else
			Operated(user)
	else
		if(user.active_slot.item)
			AppliedAtRange(user,user.active_slot.item)
		else
			OperatedAtRange(user)