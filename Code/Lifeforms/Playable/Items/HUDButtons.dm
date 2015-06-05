/button/parent_type = /obj/system

/button/icon = 'Icons/HUD/HUD.dmi'
/button/layer = FLY_LAYER + 1
/button/var/requires_not_stunned = 1
/button/var/requires_not_restrained = 1
/button/proc/Pressed(mob/user)

/button/Click()
	Pressed(usr)

/button/proc/Show(mob/mob)
	if(mob.client)
		mob.client.screen |= src

/button/proc/Hide(mob/mob)
	if(mob.client)
		mob.client.screen -= src

/button/drop/icon_state = "act_drop"
/button/drop/screen_loc = "14:27,2:5"
/button/drop/Pressed(mob/user)
	user.active_slot.Drop(user.loc)

/button/swap/left/icon_state = "hand1"
/button/swap/left/screen_loc = "7:13,2:5"
/button/swap/right/icon_state = "hand2"
/button/swap/right/screen_loc = "8:13,2:5"
/button/swap/name = "swap"
/button/swap/Pressed(mob/user)
	user.ChangeActiveSlot()

/button/equip/icon_state = "act_equip"
/button/equip/screen_loc = "7:13,2:5"
/button/equip/Pressed(mob/user)


/button/expand_slots/icon_state = "other"
/button/expand_slots/screen_loc = "1:5,1:5"
/button/expand_slots/Pressed(mob/user)
	for(var/item_slot/slot in user.item_slots)
		if(slot.slot_type.fixed) continue
		if(slot.shown) slot.Hide()
		else slot.Show()

/button/target_selector/icon_state = "zone_sel"
/button/target_selector/screen_loc = "14:27,1:5"

/button/intent/icon = 'Icons/HUD/Intent.dmi'
/button/intent/var/button/intent/alternate

/button/intent/peace/icon_state = "peace"
/button/intent/peace/screen_loc = "13:27,1:5"
/button/intent/peace/New()
	. = ..()
	alternate = new/button/intent/war
	alternate.alternate = src

/button/intent/peace/Pressed(mob/user)
	Hide(user)
	alternate.Show(user)
	user.client.mouse_pointer_icon = 'Icons/HUD/Cursor-Combat.dmi'

/button/intent/war/icon_state = "war"
/button/intent/war/screen_loc = "13:27,1:5"

/button/intent/war/Pressed(mob/user)
	Hide(user)
	alternate.Show(user)
	user.client.mouse_pointer_icon = 'Cursor.dmi'