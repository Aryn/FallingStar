#define T0C 273.15
#define T20C 293.15

/atmos/container
	var/list/gas_types = list()
	var/temperature = T20C
	var/volume = 1
	var/total_moles

	//Sets a particular gas to an amount in moles.
	proc/SetGas(gas_type,amt)
		total_moles -= gas_types[gas_type] - amt
		if(amt == 0)
			gas_types.Remove(gas_type)
			return
		gas_types[gas_type] = amt


	//Adds the provided amount of moles to the gas.
	proc/AdjustGas(gas_type,amt)
		var/existing = gas_types[gas_type]
		existing += amt
		ASSERT(existing >= 0)
		total_moles += amt
		if(existing <= 0) gas_types.Remove(gas_type)
		else gas_types[gas_type] = existing + amt

	//Retrieves the moles of gas in this gas list.
	proc/Amount(gas_type)
		return gas_types[gas_type]

	//Removes and returns a container of the specified number of moles.
	proc/RemoveMoles(n)
		ASSERT(isnum(n))
		if(!total_moles) return new/atmos/container

		var/atmos/container/removed = new
		for(var/atmos/gas_type/gas_type in gas_types)
			var/removed_amt = n * gas_types[gas_type] / total_moles
			if(gas_types[gas_type] < removed_amt)
				removed_amt = gas_types[gas_type]
			removed.AdjustGas(gas_type, removed_amt)
			AdjustGas(gas_type, -removed_amt)

		removed.temperature = temperature
		return removed

	proc/RemoveRatio(r)
		ASSERT(isnum(r))
		ASSERT(r <= 1)
		if(!total_moles) return new/atmos/container

		var/atmos/container/removed = new
		for(var/atmos/gas_type/gas_type in gas_types)
			var/removed_amt = gas_types[gas_type] * r
			removed.AdjustGas(gas_type, removed_amt)
			AdjustGas(gas_type, -removed_amt)

		removed.temperature = temperature
		return removed

	proc/RemoveVolume(L)
		ASSERT(isnum(L))

		var/ratio = L / volume
		if(ratio > 1) ratio = 1
		return RemoveRatio(ratio)

	proc/HeatCapacity()
		. = 0
		for(var/atmos/gas_type/gas_type in gas_types)
			. += gas_types[gas_type] * gas_type.specific_heat

	//Inserts the gases in another container into this one.
	proc/Insert(atmos/container/other)
		if(!other) return

		//Temperature exchange
		var/self_heat_capacity = HeatCapacity()
		var/other_heat_capacity = other.HeatCapacity()
		var/combined_heat_capacity = other_heat_capacity + self_heat_capacity
		if(combined_heat_capacity != 0)
			temperature = (other.temperature*other_heat_capacity + temperature*self_heat_capacity)/combined_heat_capacity

		//Actual gas exchange
		for(var/atmos/gas_type/gas_type in other.gas_types)
			AdjustGas(gas_type, other.gas_types[gas_type])
			other.SetGas(gas_type, 0)

	proc/Exchange(atmos/container/other)
		for(var/atmos/gas_type/gas_type in gas_types | other.gas_types)
			var/moles_per_liter = (gas_types[gas_type] + other.gas_types[gas_type]) / (volume + other.volume)
			SetGas(gas_type, moles_per_liter * volume)
			other.SetGas(gas_type, moles_per_liter * other.volume)

		var/heat_capacity = HeatCapacity()
		var/other_heat_capacity = other.HeatCapacity()
		if(heat_capacity + other_heat_capacity > 0)
			temperature = ((temperature * heat_capacity) + (other.temperature * other_heat_capacity)) / (heat_capacity + other_heat_capacity)
		other.temperature = temperature


/atmos/container/New()
	if(args.len > 0)
		ASSERT(args.len >= 2)
		for(var/i = 1, i <= args.len, i += 2)
			if(args[i+1] > 0) SetGas(args[i], args[i+1])
