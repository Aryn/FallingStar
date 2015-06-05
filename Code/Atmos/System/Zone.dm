/atmos/zone
	var/invalid = 0
	var/list/contents = list()
	var/atmos/gas_list/gases

	proc/AddTurf(turf/turf)
		contents.Add(turf)

	proc/RemoveTurf(turf/turf)
		contents.Remove(turf)