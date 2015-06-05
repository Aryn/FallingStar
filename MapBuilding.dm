turf/floor/icon = 'Icons/Objects/Tiles/Station/Floor.dmi'
turf/floor/icon_state = "floor"
turf/floor/New()
	var/tile/station/floor/floor = new(src)
	floor.icon_state = icon_state
	_AddTile(floor)
	icon = 'Icons/Objects/Space/Space.dmi'
	icon_state = "0"
	name = "space"

turf/wall/icon = 'Icons/Objects/Tiles/Station/Wall.dmi'
turf/wall/icon_state = "0"
turf/wall/New()
	var/tile/station/wall/wall = new(src)
	wall.icon_state = icon_state
	_AddTile(wall)
	icon = 'Icons/Objects/Space/Space.dmi'
	icon_state = "0"
	name = "space"