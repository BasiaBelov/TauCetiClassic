/datum/objective/heist/inviolate_crew
	explanation_text = "Не оставьте после себя ни одного вокса, на станции. Заберите всех с собой."

/datum/objective/heist/inviolate_crew/check_completion()
	var/datum/faction/heist/H = faction
	if(istype(H) && H.is_raider_crew_safe())
		return OBJECTIVE_WIN
	return OBJECTIVE_LOSS
