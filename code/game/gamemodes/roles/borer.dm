/datum/role/borer
	name = BORER
	id = BORER
	disallow_job = TRUE

	logo_state = "borer-logo"

/datum/role/borer/Greet(greeting, custom)
	. = ..()
	to_chat(antag.current, "Используйте Infest, чтобы заползти в ухо человека и слиться с его мозгом.")
	to_chat(antag.current, "Вы можете взять управление на себя только временно и рискуете причинить вред своему хозяину, поэтому будьте умны и осторожны; вашему хозяину рекомендуется помогать вам, чем он может.")
	to_chat(antag.current, "Говорите с другими вашими братьями спомощью ;")

/datum/role/borer/forgeObjectives()
	if(!..())
		return FALSE
	AppendObjective(/datum/objective/borer_survive)
	AppendObjective(/datum/objective/borer_reproduce)
	AppendObjective(/datum/objective/escape)
	return TRUE
