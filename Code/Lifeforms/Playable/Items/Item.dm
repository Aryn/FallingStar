/obj/item/var/item_slot/slot

/obj/item/Operated(mob/user)
	if(user.active_slot.TryEquip(src))
		src.Move(user)

/obj.item/test/icon = 'Icons/Objects/Items/Test.dmi'