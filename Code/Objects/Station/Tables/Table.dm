/obj/station/surface/table/icon = 'Icons/Objects/Station/Tables/Table.dmi'
/obj/station/surface/table/icon_state = "plain_preview"
/obj/station/surface/table/density = 1

/obj/station/surface/table/var/connections = list()

/hook/map_loaded/verb/LinkTables()
	for(var/obj/station/surface/table/table)
		table.LinkUp()

/obj/station/surface/table/proc/LinkUp()
	update_connections(0)
	update_icon()

/*BEGIN SHAMELESSLY BORROWED BS12 CODE*/

/obj/station/surface/table/proc/update_icon()
	icon_state = "blank"
	overlays.Cut()

	// Base frame shape. Mostly done for glass/diamond tables, where this is visible.
	for(var/n in connections)
		overlays += n

	// Standard table image
	for(var/n in connections)
		var/image/I = image(icon, "metal_[n]")
		I.color = rgb(224,224,224)
		overlays += I

// set propagate if you're updating a table that should update tables around it too, for example if it's a new table or something important has changed (like material).
/obj/station/surface/table/proc/update_connections(propagate=0)

	var/list/connection_dirs = list()
	for(var/obj/station/surface/table/T in oview(src, 1))
		if(!IsPassable(src.loc, T.loc, PASS_CONNECTION)) continue
		var/T_dir = get_dir(src, T)
		connection_dirs |= T_dir
		if(propagate)
			spawn(0)
				T.update_connections()
				T.update_icon()
	connections = dirs_to_corner_states(connection_dirs)

#define CORNER_NONE 0
#define CORNER_EASTWEST 1
#define CORNER_DIAGONAL 2
#define CORNER_NORTHSOUTH 4

/proc/dirs_to_corner_states(list/dirs)
	if(!istype(dirs)) return

	var/NE = CORNER_NONE
	var/NW = CORNER_NONE
	var/SE = CORNER_NONE
	var/SW = CORNER_NONE

	if(NORTH in dirs)
		NE |= CORNER_NORTHSOUTH
		NW |= CORNER_NORTHSOUTH
	if(SOUTH in dirs)
		SW |= CORNER_NORTHSOUTH
		SE |= CORNER_NORTHSOUTH
	if(EAST in dirs)
		SE |= CORNER_EASTWEST
		NE |= CORNER_EASTWEST
	if(WEST in dirs)
		NW |= CORNER_EASTWEST
		SW |= CORNER_EASTWEST
	if(NORTHWEST in dirs)
		NW |= CORNER_DIAGONAL
	if(NORTHEAST in dirs)
		NE |= CORNER_DIAGONAL
	if(SOUTHEAST in dirs)
		SE |= CORNER_DIAGONAL
	if(SOUTHWEST in dirs)
		SW |= CORNER_DIAGONAL

	return list("ne[NE]", "se[SE]", "sw[SW]", "nw[NW]")

#undef CORNER_NONE
#undef CORNER_EASTWEST
#undef CORNER_DIAGONAL
#undef CORNER_NORTHSOUTH