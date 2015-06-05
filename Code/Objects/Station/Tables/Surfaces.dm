/obj/station/surface/proc/TryDisassembly(mob/user, obj/item/item)
	return 1
/obj/station/surface/Applied(mob/user, obj/item/item)
	if(TryDisassembly(user, item))
		if(item.slot) item.slot.Drop(loc)