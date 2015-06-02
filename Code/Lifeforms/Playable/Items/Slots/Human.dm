var/list/ITEM_SLOTS_HUMAN = newlist(
	/button/slot_type/hand/left,
	/button/slot_type/hand/right,
	/button/slot_type/suit,
	/button/slot_type/clothes,
	/button/slot_type/mask,
	/button/slot_type/head,
	/button/slot_type/shoes,
	/button/slot_type/gloves,
	/button/slot_type/pocket/suit_pocket,
	/button/slot_type/id
	)

/*
Since active hands have a different icon, and the item slot system uses
one object per slot for all players, an additive overlay is used.
*/
var/obj/system/active_hand_icon/left/LEFT_HAND_ACTIVE = new
var/obj/system/active_hand_icon/right/RIGHT_HAND_ACTIVE = new

/obj/system/active_hand_icon/icon = 'Icons/HUD/HUD.dmi'
/obj/system/active_hand_icon/layer = FLY_LAYER + 1
/obj/system/active_hand_icon/mouse_opacity = 0
/obj/system/active_hand_icon/blend_mode = BLEND_ADD

/obj/system/active_hand_icon/left/icon_state = "left_hand_active"
/obj/system/active_hand_icon/left/screen_loc = "6:5,1:5"
/obj/system/active_hand_icon/right/icon_state = "right_hand_active"
/obj/system/active_hand_icon/right/screen_loc = "5:5,1:5"


/button/slot_type/hand/Accepts(obj/item/item)
	return istype(item)

/button/slot_type/hand/left/equip_state = "left_hand"
/button/slot_type/hand/left/screen_loc = "6:5,1:5"

/button/slot_type/hand/left/Activate(mob/owner)
	if(owner.client)
		owner.client.screen += LEFT_HAND_ACTIVE

/button/slot_type/hand/left/Deactivate(mob/owner)
	if(owner.client)
		owner.client.screen -= LEFT_HAND_ACTIVE

/button/slot_type/hand/right/equip_state = "right_hand"
/button/slot_type/hand/right/screen_loc = "5:5,1:5"

/button/slot_type/hand/right/Activate(mob/owner)
	if(owner.client)
		owner.client.screen += RIGHT_HAND_ACTIVE

/button/slot_type/hand/right/Deactivate(mob/owner)
	if(owner.client)
		owner.client.screen -= RIGHT_HAND_ACTIVE

/button/slot_type/head/equip_state = "head"
/button/slot_type/head/screen_loc = "2:7,4:11"
/button/slot_type/head/fixed = 0

/button/slot_type/mask/equip_state = "mask"
/button/slot_type/mask/screen_loc = "2:7,3:9"
/button/slot_type/mask/fixed = 0

/button/slot_type/suit/equip_state = "suit"
/button/slot_type/suit/screen_loc = "2:7,2:7"
/button/slot_type/suit/fixed = 0

/button/slot_type/clothes/equip_state = "clothes"
/button/slot_type/clothes/screen_loc = "1:5,2:7"
/button/slot_type/clothes/fixed = 0

/button/slot_type/shoes/equip_state = "shoes"
/button/slot_type/shoes/screen_loc = "2:7,1:5"
/button/slot_type/shoes/fixed = 0

/button/slot_type/gloves/equip_state = "gloves"
/button/slot_type/gloves/screen_loc = "3:9,2:7"
/button/slot_type/gloves/fixed = 0

/button/slot_type/pocket/shows_equipment = 0
/button/slot_type/pocket/Accepts(item/item)
	return 1

/button/slot_type/pocket/suit_pocket/equip_state = "suit_pocket"
/button/slot_type/pocket/suit_pocket/screen_loc = "3:9,1:5"
/button/slot_type/pocket/suit_pocket/fixed = 0

/button/slot_type/id/equip_state = "id"
/button/slot_type/id/screen_loc = "4:11,1:5"