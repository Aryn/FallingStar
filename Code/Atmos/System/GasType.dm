/atmos/gas_type
	var/name
	var/specific_heat = 20

/atmos/gas_type/New(name, molar_mass, specific_heat, properties)
	src.name = name

var/atmos/gas_type/OXYGEN = new("Oxygen")
var/atmos/gas_type/NITROGEN = new("Nitrogen")