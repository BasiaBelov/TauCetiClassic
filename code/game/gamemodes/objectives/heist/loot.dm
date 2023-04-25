/datum/objective/heist/loot
	var/loot_type

/datum/objective/heist/loot/find_target()
	var/loot = "an object"
	switch(rand(1, 7))
		if(1)
			loot_type = /obj/structure/particle_accelerator
			target_amount = 6
			loot = "комплект ускорителя частиц (6 компонентов)"
		if(2)
			loot_type = /obj/machinery/the_singularitygen
			target_amount = 1
			loot = "генератор гравитационной сингулярности"
		if(3)
			loot_type = /obj/machinery/power/emitter
			target_amount = 4
			loot = "четыре эмитера"
		if(4)
			loot_type = /obj/machinery/nuclearbomb
			target_amount = 1
			loot = "ядерную бомбу"
		if(5)
			loot_type = /obj/item/weapon/gun
			target_amount = 6
			loot = "шесть пушек"
		if(6)
			loot_type = /obj/item/weapon/gun/energy
			target_amount = 4
			loot = "четыре энергитические пушки"
		if(7)
			loot_type = /obj/item/weapon/gun/energy/ionrifle
			target_amount = 1
			loot = "ионную пушку"

	explanation_text = "Нам не хватает оборудования. Своруйте [loot]."
	return TRUE

/datum/objective/heist/loot/check_completion()
	var/total_amount = 0
	var/list/arkship_areas = list(/area/shuttle/vox/arkship, /area/shuttle/vox/arkship_hold)

	for(var/type in arkship_areas)
		for(var/obj/O in get_area_by_type(type))
			if(istype(O,loot_type)) 
				total_amount++
			for(var/obj/I in O.contents)
				if(istype(I, loot_type))
					total_amount++
			if(total_amount >= target_amount)
				return OBJECTIVE_WIN

	for(var/datum/role/raider in faction.members)
		if(raider.antag.current)
			for(var/obj/O in raider.antag.current.GetAllContents())
				if(istype(O,loot_type))
					total_amount++
				if(total_amount >= target_amount)
					return OBJECTIVE_WIN

	return OBJECTIVE_LOSS
