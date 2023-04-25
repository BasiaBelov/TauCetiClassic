/datum/objective/enthrall
	explanation_text = "Вознеситесь."

/datum/objective/enthrall/check_completion()
	var/datum/faction/shadowlings/S = faction
	return istype(S) && S.shadowling_ascended
