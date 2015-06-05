/obj/item/var/item_slot/slot
/obj/item/var/equip_slot_type

/obj/item/Operated(mob/user)
	if(user.active_slot.TryEquip(src))
		src.Move(user)