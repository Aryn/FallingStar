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

var/button/drop/BUTTON_DROP = new
/button/drop/icon_state = "act_drop"
/button/drop/screen_loc = "7:5,1:5"
/button/drop/Pressed(mob/user)
	user.active_slot.Drop(user.loc)

var/button/swap/left/BUTTON_SWAP_L = new
var/button/swap/right/BUTTON_SWAP_R = new
/button/swap/left/icon_state = "hand1"
/button/swap/left/screen_loc = "5:5,2:5"
/button/swap/right/icon_state = "hand2"
/button/swap/right/screen_loc = "6:5,2:5"
/button/swap/name = "swap"
/button/swap/Pressed(mob/user)
	user.ChangeActiveSlot()

var/button/equip/BUTTON_EQUIP = new
/button/equip/icon_state = "act_equip"
/button/equip/screen_loc = "5:5,2:5"
/button/equip/Pressed(mob/user)
	user << "\red<b>This button is not currently functional and is only present for aesthetic reasons."

var/button/expand_slots/BUTTON_EXPAND_SLOTS = new
/button/expand_slots/icon_state = "other"
/button/expand_slots/screen_loc = "1:5,1:5"
/button/expand_slots/Pressed(mob/user)
	for(var/item_slot/slot in user.item_slots)
		if(slot.slot_type.fixed) continue
		if(slot.shown) slot.Hide()
		else slot.Show()