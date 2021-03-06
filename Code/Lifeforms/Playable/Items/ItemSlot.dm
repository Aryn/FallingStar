mob/var/item_slot/active_slot

/button/slot_type/icon = 'Icons/HUD/HUD.dmi'
/button/slot_type/var/equip_state
/button/slot_type/var/fixed = 1
/button/slot_type/var/shows_equipment = 1
/button/slot_type/layer = FLY_LAYER

/button/slot_type/proc/Accepts(obj/item/item, mob/user)
	return item.equip_slot_type == name
/button/slot_type/proc/Deactivate(mob/owner)
/button/slot_type/proc/Activate(mob/owner)
/button/slot_type/New()
	. = ..()
	icon_state = equip_state

/button/slot_type/Pressed(mob/user)
	var/item_slot/myslot = user.ItemSlot(name)
	if(myslot && user.active_slot.item)
		myslot.TryEquip(user.active_slot.item)


/item_slot/var/obj/item/item
/item_slot/var/item_layer
/item_slot/var/button/slot_type/slot_type
/item_slot/var/mob/owner
/item_slot/var/shown = 0

/item_slot/var/image/item_equip_overlay

/item_slot/New(button/slot_type/slot_type, mob/owner)
	src.slot_type = slot_type
	src.owner = owner

/item_slot/proc/Show()
	if(src.owner.client)
		world << "Showing [src.slot_type.equip_state]"
		//src.owner.client.screen += slot_type
		slot_type.Show(src.owner)
		if(item)
			src.owner.client.screen += item
	else
		world << "Failed to show [src.slot_type.equip_state]"
	shown = 1

/item_slot/proc/Hide()
	if(src.owner.client)
		world << "Hiding [src.slot_type.equip_state]"
		slot_type.Hide(src.owner)
		if(item)
			src.owner.client.screen -= item
	else
		world << "Failed to hide [src.slot_type.equip_state]"
	shown = 0

/item_slot/proc/Deactivate()
	slot_type.Deactivate(owner)

/item_slot/proc/Activate()
	if(owner.active_slot) owner.active_slot.Deactivate()
	world << "Activated: [slot_type.equip_state]"
	owner.active_slot = src
	world << "Slot Type: [slot_type.type]"
	slot_type.Activate(owner)

/item_slot/proc/TryEquip(obj/item/item)
	if(slot_type.Accepts(item,owner))
		ForceEquip(item)
		return 1
	else
		return 0

/item_slot/proc/ForceEquip(obj/item/item)
	if(item.slot) item.slot._Clear()

	item.slot = src
	item_layer = item.layer
	item.layer = FLY_LAYER+2
	item.screen_loc = slot_type.screen_loc

	src.item = item

	OverlayEquipment()

	if(owner.client)
		owner.client.screen += item

/item_slot/proc/_Clear()
	if(!item) return
	if(owner.client)
		owner.client.screen -= item

	item.layer = item_layer
	owner.overlays -= item_equip_overlay

	item.slot = null
	item = null

/item_slot/proc/Drop(atom/newloc)
	if(!item) return
	if(item.Move(newloc))

		_Clear()

/item_slot/proc/OverlayEquipment()
	if(!item || !slot_type.shows_equipment) return
	if(!item_equip_overlay) item_equip_overlay = image(layer = 5)
	item_equip_overlay.icon = item.icon
	item_equip_overlay.icon_state = slot_type.equip_state
	owner.overlays += item_equip_overlay