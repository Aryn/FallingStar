/mob/humanoid/human/icon = 'Icons/Lifeforms/Playable/Human/Test.dmi'
/mob/humanoid/human/icon_state = "female_arab"

/mob/humanoid/var/item_slot/left_hand
/mob/humanoid/var/item_slot/right_hand

/mob/humanoid/human/New()
	. = ..()
	item_slots = list()
	for(var/button/slot_type/slot_type in ITEM_SLOTS_HUMAN)
		var/item_slot/slot = new(slot_type, src)
		if(slot_type.name == "left") left_hand = slot
		else if(slot_type.name == "right") right_hand = slot

		item_slots.Add(slot)

/mob/humanoid/human/Login()
	. = ..()
	for(var/item_slot/slot in item_slots)
		slot.Show()
	for(var/button/button in BUTTONS_HUMAN)
		button.Show(src)
	left_hand.Activate()

/mob/humanoid/human/ItemSlot(slot_name)
	for(var/item_slot/slot in item_slots)
		if(slot.slot_type.name == slot_name) return slot

/mob/humanoid/human/ChangeActiveSlot()
	if(active_slot == left_hand) right_hand.Activate()
	else left_hand.Activate()