#define TURF_VOLUME 5

/atmos/zone
	var/invalid = 0
	var/list/contents = list()
	var/atmos/container/gases

	New()
		air_controller.zones.Add(src)

	proc/AddTurf(turf/turf)
		gases.Insert(turf.tmp_gases)
		turf.tmp_gases = null
		turf.zone = src
		contents.Add(turf)

	proc/RemoveTurf(turf/turf)
		turf.tmp_gases = gases.RemoveVolume(TURF_VOLUME)
		turf.zone = null
		contents.Remove(turf)

	proc/Invalidate()
		air_controller.zones.Remove(src)
		invalid = 1

	proc/Rebuild()
		if(invalid) return
		Invalidate()
		for(var/turf/turf in contents)
			turf.tmp_gases = gases.RemoveVolume(TURF_VOLUME)
			turf.zone = null
			air_controller.UpdateTurf(turf)