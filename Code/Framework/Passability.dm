var/PASS_AIR = 0
var/PASS_CONNECTION = 1

atom/var/dir_density = 0
atom/var/airtight = 0
atom/var/dir_airtight = 0

proc/IsPassable(turf/A, turf/B, atom/movable/passer)
	return A.IsEnterable(get_dir(A,B), passer) && B.IsEnterable(get_dir(B,A), passer)

turf/proc/IsEnterable(direction, atom/movable/passer)
	var/atom/dense_full
	var/atom/dense_dir
	var/check_density = istype(passer,/atom/movable)
	for(var/atom/A in contents)
		if(A == passer) continue
		if(A.airtight || (check_density && A.density))
			if(!dense_full || dense_full.layer < A.layer) dense_full = A
		if((A.dir_airtight & direction) || (check_density && (A.dir_density & direction)))
			if(!dense_dir || dense_dir.layer < A.layer) dense_dir = A

	if(dense_dir)
		if(check_density) passer.Bump(dense_dir)
		return 0
	if(dense_full && passer.loc != src)
		if(check_density) passer.Bump(dense_full)
		return 0

	return 1

turf/Enter(atom/movable/A, old_loc)
	if(isturf(old_loc) && get_dist(src, old_loc) <= 1)
		return IsPassable(old_loc,src,A) && ..()
	return ..()