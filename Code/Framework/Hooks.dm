/*
Any verb attached to a hook will get called at certain points in the game.
*/

/obj/system
/hook/parent_type = /obj/system

/hook/map_loaded  //Just after the map loads
/hook/air_start   //Just after the air system starts
/hook/round_start //When a gamemode is started and all players move to their jobs.

/proc/DoHook(hook_type)
	var/hook/hook = new hook_type
	for(var/v in hook.verbs)
		call(hook,v)()

world/New()
	. = ..()
	DoHook(/hook/map_loaded)
	air_controller.Start()
	DoHook(/hook/air_start)