/tile/station/wall/icon = 'Icons/Objects/Tiles/Station/Wall.dmi'
/tile/station/wall/icon_state = "0"
/tile/station/wall/density = 1
/tile/station/wall/airtight = 1
/tile/station/wall/opacity = 1
/tile/station/wall/layer = 3

/tile/station/wall/proc/LinkUp()
	var/wall_dirs = 0
	for(var/d = 1, d <= 8, d*=2)
		var/turf/next = get_step(src,d)
		if(next && istype(next.top, /tile/station/wall))
			wall_dirs |= d

	icon_state = "[wall_dirs]"

/hook/map_loaded/verb/SetupWalls()
	for(var/tile/station/wall/wall)
		wall.LinkUp()